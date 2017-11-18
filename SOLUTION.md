## Challenges
* 帖子浏览暂时只有总的在redis上的hits记录，无法得到用户浏览的时间

## Possible Solutions
* 手工添加一个TopicView表(简单但是有可能有性能问题考虑)
* 通过log分析获取文章的阅读数量及时间(不需额外记录，但较麻烦且不稳定)
* 第三方记录gem(不一定满足需求或过于超需求)

## Pick
* 手工添加一个TopicView表, 选择原因: 处理时主要对象为一周内的数据，数据量不会过大

## Route Design
```bash
GET /topics/hot?period=[weekly | daily]
```

## Tests
