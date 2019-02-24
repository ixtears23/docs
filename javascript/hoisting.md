# hoisting

#### hoisting은 모든 선언을 scope의 상단으로 끌어 올립니다.  

 - javascript 가 runtime에 compile 될 때 변수가 scope의 맨 위로 이동합니다.  




#### example1
~~~javascript
console.log(a);
~~~
- output  
~~~javascript
Uncaught ReferenceError: a is not defined...
~~~
- 설명  
변수가 선언되지 않으면 발생하는 javascript error 입니다.  
---

#### example2
~~~javascript
console.log(a);
var a;
~~~

- output  
~~~javascript
undefined
~~~
- 설명  
변수 a를 hoisting 했기 때문에 undefined 가 출력 되었습니다.  
당연히 초기화를 해주지 않았기 때문에 undefined 입니다.  
---

#### javascript 는 선언만 hoisting 할 뿐 초기화는 hoists 하지 않습니다.
#### example3
~~~javascript
console.log(a);
var a = 5;
~~~
- output  
~~~javascript
undefined
~~~
- 설명  
변수 a는 hoisting 했지만 초기화는 hoisting 하지 않기 때문에 undefined 입니다.  
---

#### example4
~~~javascript
d = 3;

console.log(b);
console.log(d);
console.log(b + d);
var b = 5;

var d;
~~~
- output  
~~~javascript
undefined
3
NaN
~~~
- 설명  
변수 b와 d 는 hoisting 되었습니다. console.log 가 찍히기 전 변수 d만 초기화 했습니다.  
변수 b의 초기화는 hoisting 되지 않기 때문에 undefined log를 출력합니다.  
---

## let, const 는 어떻게 될까요?

### example5
~~~javascript
console.log(test);

let test;

test = 3;
~~~
- output  
~~~javascript
Uncaught ReferenceError: test is not defined...
~~~

- 설명  
var의 인스턴스는 undefined로 초기화되며, let이 값을 할당 받기 전에 let을 호출하면 참조 오류가 발생합니다.  
---

### example6
~~~javascript
const name;
name = "junseok";
~~~

- output  
~~~javascript
Uncaught SyntaxError: Missing initializer in const declaration
~~~


- 설명  
const는 초기화 될 때 동시에 값을 할당해야합니다.  

---




### Function Hoisting

- 함수도 hoisting 됩니다. 하지만 변수에 할당된 함수는 hositing 되지 않습니다.  

### example7
~~~javascript
printName();

function printName() {
	console.log("junseok");
}
~~~

- output  
~~~javascript
junseok
~~~
- 설명  
printName 함수는 hoisting 되었습니다.
---

### example8
~~~javascript
printName();

var printName = function() {
	console.log("junseok");
}
~~~

- output  
~~~javascript
Uncaught TypeError: printName is not a function
~~~
- 설명  
변수 printName 만 hoisting 되었고, 초기화는 hoisting 하지 않았기 때문입니다.  
---

## 변수를 맨 위에 선언하십시오!!
### 개발자가 호이스팅을 이해 하지 못하면 프로그램에 버그가 있을 수 있습니다.
### 버그를 피하려면 항상 모든 범위의 시작 부분에 모든 변수를 선언하십시오.
### 이것이 JavaScript가 코드를 해석하는 방식이므로 항상 좋은 규칙입니다.





