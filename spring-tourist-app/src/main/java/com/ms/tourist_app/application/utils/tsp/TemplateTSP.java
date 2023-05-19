package com.ms.tourist_app.application.utils.tsp;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

public abstract class TemplateTSP implements TSP {
    private Integer[] bestSol;
    protected Graph g;
    private double bestSolCost;
    private int timeLimit;
    private long startTime;

    public boolean searchSolution(int timeLimit, Graph g) {
        if (timeLimit <= 0) {
            return false;
        }
        startTime = System.currentTimeMillis();
        this.timeLimit = timeLimit;
        this.g = g;
        bestSol = new Integer[g.getNbVertices()];
        List<Integer> unvisited = new ArrayList<>(g.getNbVertices() - 1);
        for (int i = 1; i < g.getNbVertices(); i++) {
            unvisited.add(i);
        }
        List<Integer> visited = new ArrayList<>(g.getNbVertices());
        visited.add(0); // The first visited vertex is 0
        bestSolCost = Integer.MAX_VALUE;
        branchAndBound(0, unvisited, visited, 0);
        return true;
    }

    public Integer getSolution(int i) {
        if (g != null && i >= 0 && i < g.getNbVertices()) {
            return bestSol[i];
        }
        return -1;
    }

    public double getSolutionCost() {
        if (g != null) {
            return bestSolCost;
        }
        return -1;
    }

    /**
     * Method that must be defined in TemplateTSP subclasses
     *
     * @param currentVertex
     * @param unvisited
     * @return a lower bound of the cost of paths in <code>g</code> starting
     * from <code>currentVertex</code>, visiting every vertex in
     * <code>unvisited</code> exactly once, and returning back to vertex
     * <code>0</code>.
     */
    protected abstract double bound(Integer currentVertex, List<Integer> unvisited);

    /**
     * Method that must be defined in TemplateTSP subclasses
     *
     * @param currentVertex
     * @param unvisited
     * @param g
     * @return an iterator for visiting all vertices in <code>unvisited</code>
     * which are successors of <code>currentVertex</code>
     */
    protected abstract Iterator<Integer> iterator(Integer currentVertex, List<Integer> unvisited, Graph g);

    /**
     * Template method of a branch and bound algorithm for solving the TSP in
     * <code>g</code>.
     *
     * @param currentVertex the last visited vertex
     * @param unvisited the set of vertex that have not yet been visited
     * @param visited the sequence of vertices that have been already visited
     * (including currentVertex)
     * @param currentCost the cost of the path corresponding to
     * <code>visited</code>
     */
    private void branchAndBound(int currentVertex, List<Integer> unvisited,
                                Collection<Integer> visited, double currentCost) {
        if (System.currentTimeMillis() - startTime > timeLimit) {
            throw new RuntimeException("Time limit exceeded");
        }
        if (unvisited.size() == 0) {
            if (g.isArc(currentVertex, 0)) {
                if (currentCost + g.getCost(currentVertex, 0, false) < bestSolCost) {
                    visited.toArray(bestSol);
                    bestSolCost = currentCost + g.getCost(currentVertex, 0, false);
                }
            }
        } else if (currentCost + bound(currentVertex, unvisited) < bestSolCost) {
            Iterator<Integer> it = iterator(currentVertex, unvisited, g);
            while (it.hasNext()) {
                Integer nextVertex = it.next();
                visited.add(nextVertex);
                unvisited.remove(nextVertex);
                branchAndBound(nextVertex, unvisited, visited,
                        currentCost + g.getCost(currentVertex, nextVertex, false));
                visited.remove(nextVertex);
                unvisited.add(nextVertex);
            }
        }
    }
}
