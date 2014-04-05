# node-google-translate-unlimited
> Use google translate API simply without limit.

## How to use
```javascript
var translate = require('google-translate-unlimited')

translate({
  'sourceText': '24시간이 모자라',
  'sourceLanguage': 'auto',
  'toLanguage': 'en'
},
  function(err, result) {
    // result: { 
    //    sourceText: '24시간이 모자라',
    //    translateText: '24 hours is not enough',
    //    phonetics: '24sigan-i mojala'
    // }
    ...
});
```
