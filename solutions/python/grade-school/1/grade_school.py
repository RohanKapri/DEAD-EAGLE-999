#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 22 18:29:34 2017
Updated for changed exercise and tests on Tue May 26 12:59:43 2020

@author: bethanygarcia
"""

from collections import defaultdict

class School():
    def __init__(self):
        self._grade_levels = defaultdict(list)
        self._added = []

    def added(self):
        current_additions = self._added[:]
        self._added = []
        return  current_additions
    
    def roster(self):
        roster = (self.grade(key) for key in sorted(self._grade_levels.keys()))
        return [students for grade in roster for students in grade]
     
    def grade(self, grade_level):
        return sorted(self._grade_levels[grade_level])
    
    def add_student(self, name, grade):
        if name in self.roster():
            self._added.append(False)
        else:
            self._grade_levels[grade].append(name)
            self._added.append(True)