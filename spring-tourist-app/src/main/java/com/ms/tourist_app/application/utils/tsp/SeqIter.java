package com.ms.tourist_app.application.utils.tsp;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class SeqIter implements Iterator<Integer> {
    private Integer[] candidates;
    private int nbCandidates;

    /**
     * Create an iterator to traverse the set of vertices in <code>unvisited</code>
     * which are successors of <code>currentVertex</code> in <code>g</code>
     * Vertices are traversed in the same order as in <code>unvisited</code>
     * @param unvisited
     * @param currentVertex
     * @param g
     */
    public SeqIter(List<Integer> unvisited, int currentVertex, Graph g){
        this.candidates = new Integer[unvisited.size()];
        for (Integer s : unvisited){
            if (g.isArc(currentVertex, s))
                candidates[nbCandidates++] = s;
        }
    }

    @Override
    public boolean hasNext() {
        return nbCandidates > 0;
    }

    @Override
    public Integer next() {
        nbCandidates--;
        return candidates[nbCandidates];
    }

    @Override
    public void remove() {}
}
