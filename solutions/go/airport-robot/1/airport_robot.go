package airportrobot

import "fmt"

// Write your code here.
// This exercise does not have tests for each individual task.
// Try to solve all the tasks first before running the tests.

type Greeter interface {
	LangageName() string
	Greet(string) string
}

type Italian struct {
}

type Portuguese struct {
}

func SayHello(name string, greeter Greeter) string {
	return fmt.Sprintf("%s: %s", greeter.LangageName(), greeter.Greet(name))
}

func (italian Italian) LangageName() string {
	return "I can speak Italian"
}

func (italian Italian) Greet(name string) string {
	return fmt.Sprintf("Ciao %s!", name)
}

func (portuguese Portuguese) LangageName() string {
	return "I can speak Portuguese"
}
func (portuguese Portuguese) Greet(name string) string {
	return fmt.Sprintf("Olá %s!", name)
}