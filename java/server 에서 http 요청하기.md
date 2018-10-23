

# server에서 http요청하는 방법

- [HttpClient](https://hc.apache.org/httpcomponents-client-ga/index.html)  
  - [mavenDependency](https://hc.apache.org/httpcomponents-client-ga/httpclient/dependency-info.html)
  - [Quick Start](https://hc.apache.org/httpcomponents-client-ga/quickstart.html)
- HttpURLConnection
  
---
  
  
> 아주 간단한 sample 코드  
> 예외처리, close resource 제외  

- CloseableHttpClient
  - RequestBuilder  
  - ContentType: application/xml 

```java

  import java.net.MalformedURLException;
  import java.net.URISyntaxException;
  import java.io.IOException;

  import org.apache.http.impl.client.CloseableHttpClient;
  import org.apache.http.impl.client.HttpClients;
  import org.apache.http.client.methods.RequestBuilder;
  import java.nio.charset.Charset;
  import java.net.URI;
  import org.apache.http.client.methods.HttpUriRequest;
  import org.apache.http.HttpEntity;
  import org.apache.http.util.EntityUtils;

  
  public SiteVO siteSearch() throws MalformedURLException, URISyntaxException, IOException {
        SiteVO result = new SiteVO();

        CloseableHttpClient httpclient = HttpClients.custom().build();
        RequestBuilder requestBuilder = RequestBuilder.get();
        requestBuilder.setCharset(Charset.forName("UTF-8"));
        requestBuilder.setUri(new URI(String.format("http://site.co.kr")));
        requestBuilder.setHeader("Content-type", "application/xml");
        
        requestBuilder.addParameter("key", "value");

        HttpUriRequest uriRequest = requestBuilder.build();
        HttpEntity entity = httpclient.execute(uriRequest).getEntity();

        if (entity.isStreaming()) {
            String requestBody = EntityUtils.toString(entity, Charset.forName("UTF-8"));
            result = new Gson().fromJson(requestBody, siteVO.class);
        }
        
        return result;
  }
```

- CloseableHttpClient
  - MultipartEntityBuilder  
  - ContentType: application/octet-stream  

~~~java

  public SiteRegistVO siteRegist(HashMap<String, Object> params) throws MalformedURLException, URISyntaxException, IOException, Exception {
  
        SiteRegistVO result = new SiteRegistVO();
  
        MultipartEntityBuilder multipartEntityBuilder = MultipartEntityBuilder.create();
        multipartEntityBuilder.addTextBody("_method", "PUT", ContentType.TEXT_PLAIN.withCharset("UTF-8"));

        for (Entry<String, Object> iterable_element : params.entrySet()) {
            if (String.valueOf(iterable_element.getValue()) != null && !"".equalsIgnoreCase(String.valueOf(iterable_element.getValue()))
            && !"null".equalsIgnoreCase(String.valueOf(iterable_element.getValue()))) {
                multipartEntityBuilder.addTextBody(iterable_element.getKey(), String.valueOf(iterable_element.getValue()),
                ContentType.TEXT_PLAIN.withCharset("UTF-8"));
            }
        }
        
        File dir = new File(String.format("%s%s", "fileRoot", "fileRoute"));
        byte[] fileData;
        
        if (dir.isDirectory()) {
            fileData = fileToByte(new File(String.format("%s%s%s", "fileRoot", "fileRoute", "fileName")));
        }
        
        
        multipartEntityBuilder.addBinaryBody("fileData", fileData, ContentType.create("application/octet-stream"),
        URLEncoder.encode("originFileName", "UTF-8"));
        
        CloseableHttpClient http = HttpClients.createDefault();
        
        HttpPost post = new HttpPost();
        post.setEntity(multipartEntityBuilder.build());
        post.setURI(new URI(String.format("%s%s/%s/%s", "http://siteRegist.co.kr", "/resource", "/id", "/key")));
        CloseableHttpResponse response = http.execute(post);
        
        HttpEntity entity = response.getEntity();
        String requestBody = EntityUtils.toString(entity, Charset.forName("UTF-8"));
        result = new Gson().fromJson(requestBody, SiteRegistVO.class);
        return result;
        
  }
~~~



- CloseableHttpClient
  - RequestBuilder  
  - [kakao 로컬 주소 검색](https://developers.kakao.com/docs/restapi/tool#local-api)

~~~java

@Service
public class HttpRequest {
	
	private static Logger logger = LoggerFactory.getLogger(HttpRequest.class);
	
	private final String API_KEY = "apikey";
	
	public Map<String, Object> textRequest() {
		
		
		Map<String, Object> map = new HashMap<>();
		CloseableHttpResponse response = null;
		
		CloseableHttpClient httpClient = HttpClients.createDefault();
		
		String url = "https://dapi.kakao.com/v2/local/search/address.json";
		
		RequestBuilder requestBuilder;
		try {
			String query = URLEncoder.encode("대전", "UTF-8");
			requestBuilder = RequestBuilder.get(new URI(String.format("%s?query=%s", url, query)));
			requestBuilder.setCharset(Charset.forName("UTF-8"));
			requestBuilder.setHeader("Authorization", String.format("KakaoAK %s", API_KEY));
			
			
			HttpUriRequest request = requestBuilder.build();
			
			response = httpClient.execute(request);
			HttpEntity entity = response.getEntity();
			String entityString = EntityUtils.toString(entity);
			JSONObject result = new JSONObject(entityString);
			
			
			EntityUtils.consume(entity);
			
			
		} catch (URISyntaxException e) {
			e.printStackTrace();
			logger.debug("URISyntaxException ::: {}", e.getMessage());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			logger.debug("UnsupportedEncodingException ::: {}", e.getMessage());
		} catch (ClientProtocolException e) {
			e.printStackTrace();
			logger.debug("ClientProtocolException ::: {}", e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			logger.debug("IOException ::: {}", e.getMessage());
		} finally {
			try {
				response.close();
				httpClient.close();
			} catch (IOException e) {
				e.printStackTrace();
				logger.debug("IOException ::: {}", e.getMessage());
			}
		}

		
		return map;
	}

}

~~~
