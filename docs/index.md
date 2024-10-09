# Homepage

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Code Annotation Examples

### Codeblocks

Some `code` goes here

### Plain codeblock

a plain codeblock:

```js

Some code here
function myFunc() {
    console.log("Hello world")
}

// some comment
```

```mermaid
classDiagram
  Person <|-- Student
  Person <|-- Professor
  Person : +String name
  Person : +String phoneNumber
  Person : +String emailAddress
  Person: +purchaseParkingPass()
  Address <-- Person:lives at
  class Student{
    +int studentNumber
    +int averageMark
    +isEligibleToEnrol()
    +getSeminarsTaken()
  }
  class Professor{
    +int salary
  }
  class Address{
    +String street
    +String city
    +String state
    +int postalCode
    +String country
    -validate()
    +outputAsLabel()
  }
```
