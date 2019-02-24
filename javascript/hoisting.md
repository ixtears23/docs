# hoisting

#### hoisting은 모든 선언을 scope의 상단으로 끌어 올립니다.  




#### example1
~~~javascript
console.log(a);
~~~
- output  
~~~javascript
Uncaught ReferenceError: a is not defined...
~~~

#### example2
~~~javascript
console.log(a);
var a;
~~~

- output  
~~~javascript
undefined
~~~

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



### Function Hoisting



## 변수를 맨 위에 선언하십시오!!
### 개발자가 호이스팅을 이해 하지 못하면 프로그램에 버그가 있을 수 있습니다.
### 버그를 피하려면 항상 모든 범위의 시작 부분에 모든 변수를 선언하십시오.
### 이것이 JavaScript가 코드를 해석하는 방식이므로 항상 좋은 규칙입니다.
