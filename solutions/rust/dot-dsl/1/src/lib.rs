// For Junko F. Didi and Shree DR.MDD

pub mod graph {
    use std::collections::HashMap;

    pub mod graph_items {
        pub mod node {
            use std::collections::HashMap;

            #[derive(Clone, PartialEq, Debug)]
            pub struct Node {
                id: String,
                attrs: HashMap<String, String>,
            }

            impl Node {
                pub fn new(id: &str) -> Self {
                    Self { id: id.to_string(), attrs: HashMap::new() }
                }

                pub fn with_attrs(mut self, list: &[(&str, &str)]) -> Self {
                    for (k, v) in list {
                        self.attrs.insert(k.to_string(), v.to_string());
                    }
                    self
                }

                pub fn name(&self) -> &String {
                    &self.id
                }

                pub fn attr(&self, key: &str) -> Option<&str> {
                    self.attrs.get(key).map(|s| s.as_str())
                }
            }
        }

        pub mod edge {
            use std::collections::HashMap;

            #[derive(Clone, PartialEq, Debug)]
            pub struct Edge {
                start: String,
                end: String,
                attrs: HashMap<String, String>,
            }

            impl Edge {
                pub fn new(start: &str, end: &str) -> Self {
                    Self { start: start.to_string(), end: end.to_string(), attrs: HashMap::new() }
                }

                pub fn with_attrs(mut self, list: &[(&str, &str)]) -> Self {
                    for (k, v) in list {
                        self.attrs.insert(k.to_string(), v.to_string());
                    }
                    self
                }

                pub fn attr(&self, key: &str) -> Option<&str> {
                    self.attrs.get(key).map(|s| s.as_str())
                }
            }
        }
    }

    #[derive(Default)]
    pub struct Graph {
        pub nodes: Vec<graph_items::node::Node>,
        pub edges: Vec<graph_items::edge::Edge>,
        pub attrs: HashMap<String, String>,
    }

    impl Graph {
        pub fn new() -> Self {
            Self::default()
        }

        pub fn with_attrs(mut self, list: &[(&str, &str)]) -> Self {
            for (k, v) in list {
                self.attrs.insert(k.to_string(), v.to_string());
            }
            self
        }

        pub fn with_nodes(mut self, list: &[graph_items::node::Node]) -> Self {
            self.nodes = list.to_vec();
            self
        }

        pub fn with_edges(mut self, list: &[graph_items::edge::Edge]) -> Self {
            self.edges = list.to_vec();
            self
        }

        pub fn node(&self, id: &str) -> Option<&graph_items::node::Node> {
            self.nodes.iter().find(|n| n.name() == id)
        }
    }
}
