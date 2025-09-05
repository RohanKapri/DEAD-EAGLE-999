// For my Junko F. Didi and Shree DR.MDD  

use std::collections::HashMap;

#[derive(Clone, Copy, Debug, Eq, Hash, Ord, PartialEq, PartialOrd)]
pub struct InputCellId(usize);

#[derive(Clone, Copy, Debug, Eq, Hash, Ord, PartialEq, PartialOrd)]
pub struct ComputeCellId(usize);

#[derive(Clone, Copy, Debug, Eq, Hash, Ord, PartialEq, PartialOrd)]
pub struct CallbackId(usize);

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum CellId {
    Input(InputCellId),
    Compute(ComputeCellId),
}

#[derive(Debug, PartialEq)]
pub enum RemoveCallbackError {
    NonexistentCell,
    NonexistentCallback,
}

#[derive(Default)]
pub struct Reactor<'a, T> {
    sources: HashMap<InputCellId, T>,
    derived: HashMap<ComputeCellId, DerivedCell<'a, T>>,
    next: usize,
}

struct DerivedCell<'a, T> {
    current: T,
    rule: Box<dyn 'a + Fn(&[T]) -> T>,
    refs: Vec<CellId>,
    hooks: HashMap<CallbackId, Box<dyn 'a + FnMut(T)>>,
    next_cb: usize,
}

impl<'a, T: Copy + PartialEq + Default> Reactor<'a, T> {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn create_input(&mut self, init: T) -> InputCellId {
        let id = InputCellId(self.next);
        self.next += 1;
        self.sources.insert(id, init);
        id
    }

    pub fn create_compute<F: 'a + Fn(&[T]) -> T>(
        &mut self,
        deps: &[CellId],
        f: F,
    ) -> Result<ComputeCellId, CellId> {
        if let Some(&bad) = deps.iter().find_map(|c| match c {
            CellId::Input(i) if !self.sources.contains_key(i) => Some(c),
            CellId::Compute(cmp) if !self.derived.contains_key(cmp) => Some(c),
            _ => None,
        }) {
            Err(bad)
        } else {
            let args = deps.iter().map(|&c| self.value(c).unwrap()).collect::<Vec<_>>();
            let id = ComputeCellId(self.next);
            self.next += 1;
            self.derived.insert(
                id,
                DerivedCell {
                    current: f(&args),
                    rule: Box::new(f),
                    refs: deps.to_vec(),
                    hooks: HashMap::new(),
                    next_cb: 0,
                },
            );
            Ok(id)
        }
    }

    pub fn value(&self, id: CellId) -> Option<T> {
        match id {
            CellId::Input(i) => self.sources.get(&i).cloned(),
            CellId::Compute(c) => self.derived.get(&c).map(|d| d.current),
        }
    }

    pub fn set_value(&mut self, id: InputCellId, val: T) -> bool {
        if !self.sources.contains_key(&id) {
            return false;
        }
        if self.sources[&id] == val {
            return true;
        }
        *self.sources.get_mut(&id).unwrap() = val;
        let mut pending: HashMap<ComputeCellId, T> = HashMap::new();
        let dependents = self
            .derived
            .iter()
            .filter_map(|(cid, d)| d.refs.contains(&CellId::Input(id)).then_some(*cid))
            .collect::<Vec<_>>();
        for c in dependents {
            self.refresh(c, &mut pending);
        }
        for (c, old) in pending {
            self.fire_hooks(c, old);
        }
        true
    }

    fn refresh(&mut self, id: ComputeCellId, pending: &mut HashMap<ComputeCellId, T>) {
        let key = CellId::Compute(id);
        if let Some(prev) = self.value(key) {
            let new_val = {
                let d = &self.derived[&id];
                let args = d.refs.iter().map(|&c| self.value(c).unwrap()).collect::<Vec<_>>();
                (d.rule)(&args)
            };
            if new_val != prev {
                pending.entry(id).or_insert(prev);
                self.derived.get_mut(&id).unwrap().current = new_val;
                let nexts = self
                    .derived
                    .iter()
                    .filter_map(|(cid, d)| d.refs.contains(&key).then_some(*cid))
                    .collect::<Vec<_>>();
                for nxt in nexts {
                    self.refresh(nxt, pending);
                }
            }
        }
    }

    fn fire_hooks(&mut self, id: ComputeCellId, old: T) {
        if let Some(d) = self.derived.get_mut(&id) {
            if d.current != old {
                let val = d.current;
                for cb in d.hooks.values_mut() {
                    cb(val);
                }
            }
        }
    }

    pub fn add_callback<F: 'a + FnMut(T)>(&mut self, id: ComputeCellId, f: F) -> Option<CallbackId> {
        self.derived.get_mut(&id).map(|d| {
            let cb_id = CallbackId(d.next_cb);
            d.next_cb += 1;
            d.hooks.insert(cb_id, Box::new(f));
            cb_id
        })
    }

    pub fn remove_callback(
        &mut self,
        id: ComputeCellId,
        cb: CallbackId,
    ) -> Result<(), RemoveCallbackError> {
        match self.derived.get_mut(&id) {
            None => Err(RemoveCallbackError::NonexistentCell),
            Some(d) => {
                if d.hooks.remove(&cb).is_some() {
                    Ok(())
                } else {
                    Err(RemoveCallbackError::NonexistentCallback)
                }
            }
        }
    }
}
