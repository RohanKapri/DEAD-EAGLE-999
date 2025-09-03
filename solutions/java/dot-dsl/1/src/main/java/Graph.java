// For my Shree DR.MDD

import java.util.Collection;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

public class Graph {
    private Collection<Node> vertices;
    private Collection<Edge> links;
    private Map<String, String> properties;

    public Graph() {
        this.vertices = new ArrayList<>();
        this.links = new ArrayList<>();
        this.properties = new HashMap<>();
    }

    public Graph(Map<String, String> properties) {
        this.vertices = new ArrayList<>();
        this.links = new ArrayList<>();
        this.properties = properties;
    }

    public Collection<Node> getNodes() {
        return this.vertices;
    }

    public Collection<Edge> getEdges() {
        return this.links;
    }

    public Graph node(String id) {
        this.vertices.add(new Node(id));
        return this;
    }

    public Graph node(String id, Map<String, String> props) {
        this.vertices.add(new Node(id, props));
        return this;
    }

    public Graph edge(String from, String to) {
        this.links.add(new Edge(from, to));
        return this;
    }

    public Graph edge(String from, String to, Map<String, String> props) {
        this.links.add(new Edge(from, to, props));
        return this;
    }

    public Map<String, String> getAttributes() {
        return this.properties;
    }
}
