---
marp: true
html: true
paginate: true
header: '![image width:80px](https://go.dev/images/go-logo-blue.svg)'
footer: '![image width:80px](https://go.dev/images/gophers/pilot-bust.svg)'
style: |
    section {
        font-family: Arial, Helvetica, sans-serif;
    }
    section h1 {
        color: #00A29C;
    }
    section h2 {
        color: #00A29C;
    }

    section.cl em {
    font-style: normal;
    font-weight: bold;
    color: #00ADD8
    }
    section.cl strong {
    font-style: normal;
    font-weight: bold;
    color: #CE3263
    }
---

# Hexagonal Architecture in Go

Pallat Anchaleechamaikorn
Go Developer

yod.pallat@gmail.com
https://github.com/pallat

https://go.dev/tour
https://github.com/uber-go/guide
https://dev.to/pallat

---

## outline

Clean Architecture
Hexagonal Architecture

### repo

https://github.com/havebit/hexagonal

---

## Demo Project

Todo API

---

## The favorite questions?

How to structure our Go project?

---

## Standard is not standard

https://github.com/golang-standards/project-layout

### hot issue

https://github.com/golang-standards/project-layout/issues/117

### Who is rsc?

https://en.wikipedia.org/wiki/Go_(programming_language)

---

## Best practices lol

https://tutorialedge.net/golang/go-project-structure-best-practices/

### WTF Architecture in Go

https://pallat.medium.com/wtf-architecture-in-go-19f20ffd30ef

or

https://github.com/dgryski/awesome-go-style

## Java-esque

https://twitter.com/dgryski/status/1443613501251993609

---

## Clean Architecture

![image width:600px](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

---

## Clean Architecture 

![image width:600px](https://codersopinion.com/images/posts/clean-architecture/clean-architecture.png)

---

## Clean Architecture 

![image width:600px](https://netsharpdev.com/images/posts/shape.png)

---

## Hexagonal Architecture

https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html

![image width:600px](https://miro.medium.com/max/1400/1*NfFzI7Z-E3ypn8ahESbDzw.png)

---

## Hexagonal Architecture

![image width:600px](https://miro.medium.com/max/1400/0*Rg4n-AdiSBwJaTJR.png)

---

## Hexagon

![image width:600px](https://f.btwcdn.com/store-48145/product/1a48e611-33a3-74cb-53e2-605ab884c4cc.jpg)

---

## What we see when googling about "Hexagonal golang"

https://github.com/iDevoid/stygis
https://golangexample.com/hexagonal-architecture-implemented-in-go/
https://www.linkedin.com/pulse/hexagonal-software-architecture-implementation-using-golang-ramaboli/
https://medium.com/@iqbalmaulana.ardi/hexagonal-model-architecture-in-go-language-a4dd338baf53
https://threedots.tech/post/introducing-clean-architecture/
https://medium.com/@matiasvarela/hexagonal-architecture-in-go-cfd4e436faa3

---

## Inspired by

https://beyondxscratch.com/2017/08/19/hexagonal-architecture-the-practical-guide-for-a-clean-architecture/

---

## Why do we need the Clean Architecture?

1. Hard to Test
2. Hard to Change

![image](hard_to_change_test.png)

---

## What make it hard?

```go
func NewTodoHandler(db *gorm.DB) *TodoHandler {
   return &TodoHandler{db: db}
}

func (t *TodoHandler) NewTask(c *gin.Context) {
```

    db *gorm.DB
    c *gin.Context

---

## Hexagonal Architecture

![image width:600px](hexagonal.png)

---

## Ports and Adapters

![image width:400px](https://www.dossier-andreas.net/software_architecture/ports-and-adapters.png)

---

## Ports and Adapters

![image height:500px](ports_adapters.png)

---

## Hexagonal

![image width:650px](https://beyondxscratch.com/wp-content/uploads/2020/08/implementation-of-the-hexagonal-architecture.png)

SPI: Service Provider Interface

---

## Then...

.
..
    -adapters/
    -domain/
    -ports/

### Do not start with how it structures

### Let's start with how it works

---

## Let's started

### 3 Layers

- Domain (Objects) & Business Logic
- Ports
- Adapters

---

## Adapters

- gorm
- gin

---

## Define Ports to replace gorm

```go
r := t.db.Create(&todo)
```

example

```go
err := t.store.New(&todo)
```

interface

```go
type storer interface {
   New(*Todo) error
}
```

---

## Implement storer interface

---

## Define Ports to replace gin

```go
c.ShouldBindJSON(&todo)
c.JSON(http.StatusBadRequest, gin.H{
    "error": "not allowed",
})
```

interface

```go
type Context interface {
   Bind(interface{}) error
   JSON(int, interface{})
}
```

---

## Implement Context interface

```go
type MyContext struct{
    *gin.Context
}

func NewGinHandler(handler MyHandlerFunc) gin.HandlerFunc {
   return func(c *gin.Context) {
       handler(&MyContext{Context: c})
   }
}
```

![image width:500px](handler_gin_interface.png)

---

## Let's Test it

---

## Which side to define the interface?

Caller vs Callee

---

## Change DB

---

## Change web-framework

---
