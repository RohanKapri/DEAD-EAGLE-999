// Dedicated to Shree DR.MDD
import java.util.*;
class PythagoreanTriplet {

    private final int x, y, z;
    
    PythagoreanTriplet(int x, int y, int z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    static TripletListBuilder makeTripletsList() {
        return new TripletListBuilder();
    }

    @Override
    public boolean equals(Object obj) {
        PythagoreanTriplet cmp = (PythagoreanTriplet) obj;
        return x == cmp.x && y == cmp.y && z == cmp.z;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y, z);
    }

    static class TripletListBuilder {

        private int targetSum = -1, limitFactor = -1;

        TripletListBuilder thatSumTo(int targetSum) {
            this.targetSum = targetSum;
            return this;
        }

        TripletListBuilder withFactorsLessThanOrEqualTo(int limitFactor) {
            this.limitFactor = limitFactor;
            return this;
        }

        List<PythagoreanTriplet> build() {
            List<PythagoreanTriplet> collection = new ArrayList<>();
            if (targetSum == -1) return List.of();
            if (limitFactor == -1) limitFactor = targetSum - 3;
            
            for (int x = 3; x <= Integer.min(limitFactor - 2, targetSum / 3); x++) {
                int y = (targetSum * targetSum - 2 * targetSum * x) / (2 * targetSum - 2 * x);
                int z = targetSum - x - y;
                if (x < y && y < z && y <= limitFactor && z <= limitFactor && x * x + y * y == z * z) {
                    collection.add(new PythagoreanTriplet(x, y, z));
                }
            }
            return collection;
        }

    }

}
