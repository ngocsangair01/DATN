package com.ms.tourist_app.application.utils.tsp;

public interface Graph {
    /**
     * @return the number of vertices in <code>this</code>
     */
    public abstract int getNbVertices();

    /**
     * @param i
     * @param j
     * @param isDistance
     * @return the cost of arc (i,j) if (i,j) is an arc; -1 otherwise
     */
    public abstract double getCost(int i, int j, boolean isDistance);

    /**
     * @param i
     * @param j
     * @return true if <code>(i,j)</code> is an arc of <code>this</code>
     */
    public abstract boolean isArc(int i, int j);

    public abstract double[][] getCostTable();

    public abstract double getMinCost();
}
