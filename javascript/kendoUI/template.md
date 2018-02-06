[[ Template API ]](https://docs.telerik.com/kendo-ui/framework/templates/overview)

## 템플릿 개요

> Kendo UI 템플릿은 Kendo UI 툴킷 내에서 사용이 간편한 고성능 JavaScript 템플릿 엔진을 제공합니다.  
> 템플릿을 사용하면 JavaScript 데이터와 자동으로 병합 할 수있는 HTML 청크를 만들 수 있습니다.  
> 이들은 JavaScript로 작성된 전통적인 HTML 문자열 대신 사용할 수 있습니다.


## 기초
> Kendo UI 템플릿은 일반적인 사용자 인터페이스 (UI) 렌더링 시나리오에 필요한  
> 필수 템플릿 기능을 제공하는 데 중점을두고 있으며 기능 과잉에 비해 성능에 중점을 둡니다.  
> Kendo UI Templates는 성능 향상을 위해 편리한 구문 설탕을 사용합니다.  
> 이 템플릿은 다른 템플릿 JavaScript 라이브러리와 구별됩니다. 

## 템플릿 구문

> Kendo UI 템플릿은 해시 템플릿이라는 간단한 템플릿 구문을 사용합니다.  
> 이 구문을 사용하면 템플릿이 실행될 때 데이터로 대체되어야하는 템플릿의 영역을 표시하는데 #(해시)기호가 사용됩니다.  
> \# 문자는 템플릿 내에서 사용자 정의 JavaScript 코드의 시작과 끝을 나타내는 데에도 사용됩니다.  

##### 해시 구문을 사용하는 세 가지 방법이 있습니다.
1. HTML로 값 렌더링 : `#= #.`
2. HTML 인코딩을 사용하여 값 표시 : `#: #.`
3. 임의의 JavaScript 코드 실행 : `# if (true) { # ... non-script content here ... # } #.`

## 해시 리터럴(Hash Literals)
### 중요한
> - 서식 파일에 바인딩 식의 일부가 아니며 스크립트 코드 표식이 아닌 리터럴 # 문자가 포함되어 있으면  
> 해당 문자를 이스케이프 처리해야합니다. 그렇지 않으면 템플릿 컴파일 오류가 발생합니다.  
> 예를 들어, #이 하이퍼 링크 URL 또는 CSS 색상 값 내에서 사용되는 경우이 문제가 발생할 수 있습니다.  
> JavaScript 문자열의 Literal #은 `\\\\#`을 통해 이스케이프 처리되지만  
> 외부 HTML 스크립트 템플릿의 리터럴 #은 `\\#`을 통해 이스케이프 처리됩니다.  
> - 템플릿에 중첩 템플릿의 바인딩 표현식의 일부인 # 문자가 포함되어 있으면이 문자도 이스케이프해야합니다.  
> 이 방법으로 문자는 외부 템플릿에 의해 무시되지만 내부 템플릿에 의해 올바르게 처리됩니다.  

##### 이러한 Kendo UI 템플릿 구문을 문맥에서 사용하는 방법에 대한 자세한 내용은 아래 섹션을 참조하십시오.

### Render Raw Values(원시 값 렌더링)
> 가장 기본적인 템플리트 작업 중 하나는 템플리트에서 그대로 값을 렌더링하는 것입니다.  
> Kendo UI 템플릿을 사용하면 다음 코드를 통해 수행 할 수 있습니다.  
~~~javascript
  var template = kendo.template("<div id='box'>#= firstName #</div>");
~~~
> 이 방법은 데이터로 렌더링 할 준비가 된 컴파일 된 인라인 템플릿을 만듭니다.  
> 아래 예제는 응용 프로그램에서 템플릿을 어떻게 사용하는지 보여줍니다.
~~~jsp
    <div id="example"></div>
    <script>
        var template = kendo.template("<div id='box'>#= firstName #</div>");
        var data = { firstName: "Todd" }; //A value in JavaScript/JSON
        var result = template(data); /Pass the data to the compiled template
        $("#example").html(result); //display the result
    </script>
~~~

### Render HTML-Encoded Values(렌더링 된 HTML 인코딩 값)
> 템플릿에서 인코딩 된 HTML 값을 렌더링하려는 경우 Kendo UI 템플릿에서 자동으로 인코딩을 처리 할 수 있습니다.  
> 이렇게하려면 약간 다른 구문을 사용하십시오.  
~~~javascript
    var template = kendo.template("<div id='box'>#: firstName #</div>");
~~~
> 아래 예제는 템플릿이 소비되고 데이터에 HTML 문자가 있다고 가정했을 때 생성 된 출력을 보여줍니다.  
~~~jsp
    <div id="example"></div>
    <script>
        var template = kendo.template("<div id='box'>#: firstName #</div>");
        var data = { firstName: "<b>Todd</b>" }; //Data with HTML tags
        var result = template(data); //Pass the data to the compiled template
        $("#example").html(result); // display the following string result ("<b>Todd</b>")
    </script>
~~~
> HTML 인코딩을 사용하지 않으면 아래와 같이 출력됩니다.  
~~~jsp
    <div id="example"></div>
    <script>
        var template = kendo.template("<div id='box'>#= firstName #</div>");
        var data = { firstName: "<b>Todd</b>" }; //Data with HTML tags
        var result = template(data); //Pass the data to the compiled template
        $("#example").html(result); //display "Todd" in a bold font weight
    </script>
~~~

> HTML 인코딩은 템플릿에 HTML 태그를 렌더링하지 않으려는 경우에 유용합니다.  
> 데이터의 HTML 태그를 이스케이프하고 태그를 문자열로 렌더링합니다.  
> 사용자 제출 값과 같이 알 수없는 출처의 데이터로 작업하는 경우 사용자가 페이지 레이아웃에  
> 영향을 줄 수있는 HTML 마크 업을 콘텐츠에 포함시킨 경우 HTML 인코딩을 사용하십시오.  

### Handle External Templates and Expressions(외부 템플릿 및 표현식 처리)
> 템플릿에 표현식을 포함시키는 것이 일반적입니다.  
> 일부 템플릿 프레임 워크는 성능 저하로 표현 설탕을 제공하기 위해 자바 스크립트를 다시 구현하지만  
> Kendo UI 템플릿은 일반 자바 스크립트를 템플릿 내에서 실행하도록 허용하여 값 비싼 구문 설탕보다 성능이 더 좋습니다.  

- ##### [syntax sugar](https://www.zerocho.com/category/JavaScript/post/5816c858ca15d50015d924ae)
> 직관적이지는 않지만 코드의 양을 줄여준다.  
~~~javascript
var a;
if (b) {
  a = b;  
} else if (c) {
  a = c;
} else {
  a = d;
}
~~~
~~~javascript
var a = b || c || d;
~~~

> 아래 예제는 JavaScript 및 Kendo UI 템플릿을 사용하여 항목 목록을 표시하는 방법을 보여줍니다.  
~~~jsp
    <script id="javascriptTemplate" type="text/x-kendo-template">
        <ul>
        # for (var i = 0; i < data.length; i++) { #
            <li>#= myCustomFunction(data[i]) #</li>
        # } #
        </ul>
    </script>
~~~
> 그런 다음 이 외부 템플릿을 표현식과 함께 사용하려면  
> 이 정의를 사용하는 템플릿을 초기화하고 아래에 설명 된대로 값 배열을받습니다.  
~~~jsp
    <div id="example"></div>

    <script id="javascriptTemplate" type="text/x-kendo-template">
        <ul>
        # for (var i = 0; i < data.length; i++) { #
            <li>#= myCustomFunction(data[i]) #</li>
        # } #
        </ul>
    </script>

    <script type="text/javascript">
        // use a custom function inside the template. Must be defined in the global JavaScript scope
        function myCustomFunction (str) {
            return str.replace(".", " ");
        }

        //Get the external template definition using a jQuery selector
        var template = kendo.template($("#javascriptTemplate").html());

        //Create some dummy data
        var data = ["Todd.Holland", "Steve.Anglin", "Burke.Ballmer"];

        var result = template(data); //Execute the template
        $("#example").html(result); //Append the result
    </script>
~~~
> 위의 코드에서 볼 수 있듯이 JavaScript는 템플릿 내부에서 for 루프를 실행하고  
> 각 이름에 대한 HTML 목록 항목을 생성합니다.  
> 보조 전역 JavaScript 함수는 표시하는 동안 각 데이터 항목을 조작하는 데 사용됩니다.  
> 사용자 지정 변수는 템플릿 식 내부에서 정의 된 다음 데이터 필드와 동일한 방식으로 출력 할 수 있습니다.  
~~~jsp
    <script id="javascriptTemplate" type="text/x-kendo-template">
        # var myCustomVariable = "foo"; #
        <p>
            #= myCustomVariable #
        </p>
    </script>
~~~
> 아래에 설명 된 것처럼 HTML 주석 내에서도 표현식이 실행된다는 점에 유의하십시오.  
~~~jsp
<!-- #alert('it is executed!')# -->
~~~

> 마지막으로 Kendo UI MVC 래퍼의 Name () 메서드에서 스크립트 식을 사용하는 데는 제한이 있습니다.  

## Inline vs. External Templates(인라인 vs 외부 템플릿)
> Kendo UI 템플릿은 두 가지 방법으로 정의 할 수 있습니다.  
> - 인라인 \- 자바 스크립트 문자열을 사용하며 작은 템플릿에 유용합니다.  
> - 외부 \- HTML 스크립트 블록을 사용합니다.  
> 논리 또는 HTML 마크 업을 포함하는 가장 큰 템플릿은 외부 템플릿을 사용해야합니다.  
> 외부 템플릿은 JavaScript 대신 HTML에 저장되기 때문에 디자이너가 만들고 수정할 수 있습니다.  

### 인라인 템플릿 만들기
> 인라인 템플릿을 만들려면 JavaScript 문자열을 만듭니다.  
~~~javascript
    var templateString = "Your name is #: myName #";
    var template = kendo.template(templateString);
~~~
> 템플릿에 전달 된 데이터에 myName이라는 변수가 있으면이 템플릿이 작동합니다.  
> 인라인 템플릿에 리터럴 \#이 포함되어 있으면 아래에 표시된 방법으로 이스케이프해야합니다.  
~~~javascript
    var templateString = '<a href="\\#index">#: myName #</a>';
~~~
> 예제에서 볼 수 있듯이 이렇게하면 앵커 태그가 페이지에 표시됩니다.  
~~~html
    <div id="example"></div>

    <script type="text/javascript">
        var templateString = '<a href="\\#index">#: myName #</a>';
        var template = kendo.template(templateString);

        $("#example").html(template({ myName: "Todd" }));
    </script>
~~~
### 외부 템플릿 만들기
> 외부 템플릿은 자바 스크립트가 아닌 HTML의 특수 블록에 저장됩니다.  
> 외부 템플릿을 정의하려면 `text/x-kendo-template` 유형으로 HTML에 스크립트 블록을 만듭니다.  
~~~html
    <script type="text/x-kendo-template" id="myTemplate">
        <!--Template content here-->
    </script>
~~~html

### 중요한
> `text/x-kendo-template` 유형은 특별히 필요하지 않습니다.  
> Visual Studio를 사용할 때 유형을 `text/html`로 설정하여 구문 강조를 유지할 수 있습니다.  
> 유형으로 거의 모든 값을 사용할 수 있습니다.  
> text/javascript를 제외하고, 런타임에서 템플릿을 사용하는 경우를 제외하고 브라우저가 블록을 렌더링하지 못하도록합니다.  

> 외부 템플릿에는 항상 ID가 있어야 JavaScript에서 초기화 할 때 템플릿 내용을 선택할 수 있습니다.  
~~~javascript
    //extract the template content from script tag
    var templateContent = $("#myTemplate").html();
    //compile a template
    var template = kendo.template(templateContent);
~~~

> 외부 템플릿 내에서 Kendo UI 템플릿 구문으로 JavaScript의 형식이 올바르게 지정되어 있으면  
> HTML과 JavaScript를 추가 할 수 있습니다 (아래에 표시된 것처럼).
~~~html
    <script type="text/x-kendo-template" id="myTemplate">
        #if(isAdmin){#
            <li>#: name # is Admin</li>
        #}else{#
            <li>#: name # is User</li>
        #}#
    </script>
~~~
> 아래 예제는 요약 된 샘플 사례를 보여줍니다.  
~~~html
    <ul id="users"></ul>

    <script type="text/x-kendo-template" id="myTemplate">
        #if(isAdmin){#
            <li>#: name # is Admin</li>
        #}else{#
            <li>#: name # is User</li>
        #}#
    </script>

    <script type="text/javascript">
        var templateContent = $("#myTemplate").html();
        var template = kendo.template(templateContent);

        //Create some dummy data
        var data = [
            { name: "John", isAdmin: false },
            { name: "Alex", isAdmin: true }
        ];

        var result = kendo.render(template, data); //render the template

        $("#users").html(result); //append the result to the page
    </script>
~~~

### 중요한
> Kendo UI는 루프와 같은 항목에 대한 도우미 구문을 제공하지 않습니다.  
> 다른 템플릿 라이브러리에는 {each}와 같은 속기가 있지만  
> Kendo UI는 사용자 정의 구문 설탕 대신 일반 JavaScript를 사용합니다.  
> 그 이유는 자바 스크립트를 사용하는 사람이라면 누구나 쉽게 사용할 수 있기 때문입니다.  
> JavaScript를 알고 있다면 Kendo UI 템플릿을 알 수 있습니다.
