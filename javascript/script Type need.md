


# HTML5 스크립트 태그에 type = "javascript"가 필요합니까?

[[스택오버 플로우 참고]](https://stackoverflow.com/questions/14323376/do-html5-script-tag-need-type-javascript)
  
  
아니, [이제는 공식적으로 쓸모가 없어.](https://www.w3.org/TR/html5/scripting-1.html#the-script-element)  
`type` 속성은 스크립트 언어 또는 데이터 형식을 제공합니다.  
속성이있는 경우 값은 유효한 `MIME` 유형이어야합니다.  
`charset` 매개 변수를 지정하지 않아야합니다.  
속성이없는 경우 사용되는 기본값은 `text/javascript`입니다. 

- simple
~~~javascript
<script src=yourpath.js></script>
~~~

예, [따옴표도 생략 할 수 있습니다.](http://w3c.github.io/html/syntax.html#elements-attributes)  

`HTML5` 이전 브라우저는 걱정할 필요가 없습니다.  
항상 `HTML5` 브라우저가 기본 스크립트 언어로 간주됩니다  
