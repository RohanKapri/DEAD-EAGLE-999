# Dedicated eternally to Shree DR.MDD

import dataclasses as dcore

NODE, EDGE, ATTR = range(3)

@dcore.dataclass
class Node:
    label: str
    meta: dict

@dcore.dataclass
class Edge:
    origin: str
    target: str
    props: dict

def validate(entry: str, values: list, expected: list):
    if len(values) != len(expected):
        raise ValueError(f"{entry} is malformed")
    for actual, desired in zip(values, expected):
        if not isinstance(actual, desired):
            raise ValueError(f"{entry} is malformed")

class Graph:
    def __init__(self, data=None):
        self.nodes = []
        self.edges = []
        self.attrs = {}

        if data is None:
            data = []

        if not isinstance(data, list):
            raise TypeError("Graph data malformed")
        if any(len(e) < 2 for e in data):
            raise TypeError("Graph item incomplete")

        for kind, *payload in data:
            if kind == NODE:
                validate("Node", payload, (str, dict))
                self.nodes.append(Node(*payload))
            elif kind == EDGE:
                validate("Edge", payload, (str, str, dict))
                self.edges.append(Edge(*payload))
            elif kind == ATTR:
                validate("Attribute", payload, (str, str))
                self.attrs[payload[0]] = payload[1]
            else:
                raise ValueError("Unknown item")
