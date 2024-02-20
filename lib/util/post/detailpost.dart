import 'package:inglo/models/post/detail_post.dart';

class DetailPostPreferences {
  static final detailPost = DetailPost(
    id: 7,
    user: 2,
    sketch: DetailSketch(
      id: 4,
      user: "hsw0106@gmail.com",
      title: "일하기싫다 테테테스",
      image_url: "https://inglo-bucket.s3.ap-northeast-2.amazonaws.com/user_2/sketch_4",
      created_at: "2024-02-17T21:24:26.594716Z",
      problem: "내일 약속을 잡은게 문제다",
      hmw: "저녁을 안먹는건 어떨까",
      crazy8stck: [
        CrazyItem(content: "테스트1"),
        CrazyItem(content: "테스트2"),
        CrazyItem(content: "테스트3"),
        CrazyItem(content: "테스트4"),
        CrazyItem(content: "테스트5"),
        CrazyItem(content: "테스트6"),
        CrazyItem(content: "테스트7"),
        CrazyItem(content: "테스트8"),
      ],
    ),
    title: "포스트 생성아주아주긴기기기기기기기기제목메저고거고ㅓ마와ㅓㅁ오ㅓㅏㄴ모아ㅓㄴ모어ㅏㄴㅁ오나ㅓ몽나ㅓㅁ오",
    image_url: "https://inglo-bucket.s3.ap-northeast-2.amazonaws.com/user_2/post_7",
    content: '''
      <!DOCTYPE html>
      <html>
      <head>
        <title>Example Post</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            font-size: 24px;
            color: #333;
          }
          h1 {
            font-size: 32px;
            font-weight: bold;
            color: #000;
          }
          p {
            margin: 10px 0;
          }
          img {
            max-width: 100%;
            height: auto;
          }
        </style>
      </head>
      <body>
        <h1>This is the title of the post</h1>
        <p>This is a paragraph describing the content of the post. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget risus eget massa semper consectetur eu nec leo. Praesent tempus vel libero vel suscipit. Integer mattis nunc non feugiat venenatis.</p>
        <img src="https://via.placeholder.com/600" alt="Example Image">
        <p>This is another paragraph. Nullam fermentum, quam sit amet fermentum vehicula, enim nunc bibendum odio, vel rhoncus lorem ex eu velit.</p>
      </body>
      </html>
    ''',
    sdgs: 1,
    likes: 0,
    created_at: "2024-02-18T16:19:37.412607Z",
    feedbacks: [],
    is_liked: false,
  );
}
