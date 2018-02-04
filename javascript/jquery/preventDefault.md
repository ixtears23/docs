# e.preventDefault();

설명 :이 메서드를 호출하면 이벤트의 기본 동작이 트리거되지 않습니다.  

이 메소드는 인수를 허용하지 않습니다.  

예를 들어, 클릭 된 앵커는 브라우저를 새 URL로 가져 가지 않습니다.  
event.isDefaultPrevented ()를 사용하여이 메서드가 이 이벤트에 의해  
트리거 된 이벤트 처리기에 의해 호출되었는지 확인할 수 있습니다.  

예: 클릭의 기본 동작 (탐색)을 취소합니다.  
~~~html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>event.preventDefault demo</title>
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
 
<a href="http://jquery.com">default click action is prevented</a>
<div id="log"></div>
 
<script>
$( "a" ).click(function( event ) {
  event.preventDefault();
  $( "<div>" )
    .append( "default " + event.type + " prevented" )
    .appendTo( "#log" );
});
</script>
 
</body>
</html>
~~~

event.preventDefault () 메서드는 요소의 기본 동작을 중지합니다.  
- Prevent a submit button from submitting a form
- Prevent a link from following the URL


`event.isDefaultPrevented ()` 메서드를 사용하여  
`preventDefault ()` 메서드가 이벤트에 대해 호출되었는지 여부를 확인합니다.  

### event.isDefaultPrevented()
~~~javascript
$( "a" ).click(function( event ) {
  alert( event.isDefaultPrevented() ); // false
  event.preventDefault();
  alert( event.isDefaultPrevented() ); // true
});
~~~

