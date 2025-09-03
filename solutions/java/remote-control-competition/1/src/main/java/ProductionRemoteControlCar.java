class ProductionRemoteControlCar implements RemoteControlCar, Comparable<ProductionRemoteControlCar> {
    private int distance;
    private int victories;
    @Override
    public void drive() {
        distance += 10;
    }
    @Override
    public int getDistanceTravelled() {
        return distance;
    }
    public int getNumberOfVictories() {
        return victories;
    }
    @Override
    public int compareTo(ProductionRemoteControlCar that){
        return that.getNumberOfVictories()-getNumberOfVictories();
    }
    public void setNumberOfVictories(int numberofVictories) {
        victories = numberofVictories;
    }
}
