// Dedicated to Shree DR.MDD
import java.util.*;
import java.util.function.*;

public class React {

    public static class Cell<T> {
        protected List<DerivedCell<T>> derivedNodes = new ArrayList<>();
        protected T storedVal;
        
        public T getValue() {
            return storedVal;
        }

        protected void addComputeCell(DerivedCell<T> depNode) {
            derivedNodes.add(depNode);
        }

        protected void updateComputeCells() {
            derivedNodes.stream().forEach(DerivedCell::refreshVal);
            derivedNodes.stream().forEach(DerivedCell::updateComputeCells);
        }

        protected void callback() {
            derivedNodes.stream().forEach(DerivedCell::invoke);
            derivedNodes.stream().forEach(DerivedCell::callback);
        }
    }

    public static class InputCell<T> extends Cell<T> {
        
        public void setValue(T updatedVal) {
            storedVal = updatedVal;
            updateComputeCells();
            callback();
        }
    }

    public static class DerivedCell<T> extends Cell<T> {
        private List<Consumer<T>> observers = new ArrayList<>();
        private Function<List<T>, T> formula;
        private List<Cell<T>> sources;
        private boolean altered;
        
        public DerivedCell(Function<List<T>, T> formula, List<Cell<T>> sources) {
            this.formula = formula;
            this.sources = sources;
            refreshVal();
        }
        
        public void addCallback(Consumer<T> listener) {
            observers.add(listener);
        }

        public void removeCallback(Consumer<T> listener) {
            observers.remove(listener);
        }

        protected void refreshVal() {
            T evaluated = formula.apply(sources.stream().map(Cell::getValue).toList());
            if (!Objects.equals(storedVal, evaluated)) {
                storedVal = evaluated;
                altered = true;
            } else {
                altered = false;
            }
        }

        protected void invoke() {
            if (altered) observers.forEach(obs -> obs.accept(storedVal));
            altered = false;
        }
    }

    public static <T> InputCell<T> inputCell(T baseVal) {
        InputCell<T> inp = new InputCell<>();
        inp.setValue(baseVal);
        return inp;
    }

    public static <T> DerivedCell<T> computeCell(Function<List<T>, T> func, List<Cell<T>> dependencies) {
        DerivedCell<T> calcNode = new DerivedCell<>(func, dependencies);
        dependencies.forEach(dep -> dep.addComputeCell(calcNode));
        return calcNode;
    }
}
