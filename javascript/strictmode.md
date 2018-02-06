# "use strict"
> Strict Mode는 ECMAScript 5의 새로운 기능으로 프로그램이나 함수를 "엄격한"운영 환경에 배치 할 수 있습니다.  
> 이 엄격한 컨텍스트는 특정 작업을 수행하지 못하게하고 더 많은 예외를 throw합니다.  
> (일반적으로 사용자에게보다 많은 정보와 테이퍼 다운 코딩(tapered-down coding) 경험 제공).  

[[참고사이트]](http://blog.aliencube.org/ko/2014/01/02/reasons-behind-using-strict-mode-while-coding-javascript/)

- strict mode의 이점
  - 예외를 던지면서 일반적인 코딩 블로퍼를 잡습니다.
  - 상대적으로 "안전하지 않은"동작 (예 : 전역 개체에 대한 액세스 권한 획득)이 
    발생하면 오류를 방지하거나 오류를 throw합니다.
  - 혼란 스럽거나 잘못 생각한 기능은 사용할 수 없습니다.

> strict mode에 대한 대부분의 정보는 [[ES5 사양 (PDF) # 235]](http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf) 페이지에 나와 있습니다.  

[[JavaScript(ECMAScript)]](http://d2.naver.com/helloworld/2809766)


- strict mode 활성화 방법
> 전체스크립트에서 활성화 하려면 프로그램 상단에 아래 코드를 작성하면 된다.
~~~javascript
"use strict";
~~~
> 또는 함수내에서만 strict mode를 활성화 할 수 있다.
~~~javascript
function imStrict(){
  "use strict";
  // ... your code ...
}
~~~

> 단순히 `"use strict"`라는 내용을 포함하는 한 문장의 문자열이다.  
> 최악의 경우에도 오래된 브라우저에서 부작용이 없다.  

~~~javascript
// Non-strict code...
 
(function(){
  "use strict";
   
  // Define your library strictly...
})();
 
// Non-strict code...
~~~

---
정리하다 말음..
[[use strict]](https://johnresig.com/blog/ecmascript-5-strict-mode-json-and-more/)

- Strict mode 지원 브라우저 버전  
  - IE version 10. 
  - Firefox version 4.
  - Chrome version 13. 
  - Safari version 5.1.
  - Opera version 12.

