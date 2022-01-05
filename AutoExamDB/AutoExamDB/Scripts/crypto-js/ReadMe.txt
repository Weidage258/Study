在html页面使用script标签引入这些，就可以使用了， 不过第一要先引入core.js文件，然后再根据需要引入某个单独的加密方法文件
  比如：  我是只使用了md5和sha1加密
    <!-- 加密使用 -->
    <script src="./js/core.js"></script>
    <script src="./js/md5.js"></script>
    <script src="./js/sha1.js"></script>

  直接使用就行了:            
    // sha1加密
    CryptoJS.SHA1("hello world").toString(CryptoJS.enc.Hex);
   // MD5加密
    CryptoJS.MD5(“hello world”).toString(CryptoJS.enc.Hex)
其他的加密的方法使用直接搜文档就ok了