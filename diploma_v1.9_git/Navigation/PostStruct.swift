
import UIKit

struct Post {
    var title: String
    var author: String
    var description: String
    var image: UIImage
    var likes: Int
    var views: Int
}

var firstPost = Post(title: "Первый пост",
                     author: "Forbes Russia",
                     description: "Когда рушится мир: как быстро привести себя в порядок в невыносимой ситуации",
                     image: PostImages.firstPostImg,
                     likes: 238,
                     views: 867)


var firstPostFull = Post(title: "Первый пост",
                     author: "Forbes Russia",
                     description: firstPostText,
                     image: PostImages.firstPostImg,
                     likes: 238,
                     views: 867)

var secondPost = Post(title: "Второй пост",
                      author: "Forbes Russia",
                      description: "Запрет на развитие: как российские технологии выживут без полупроводников",
                      image: PostImages.secondPostImg,
                      likes: 123,
                      views: 944)

var secondPostFull = Post(title: "Второй пост",
                      author: "Forbes Russia",
                      description: secondPostText,
                      image: PostImages.secondPostImg,
                      likes: 123,
                      views: 944)

var thirdPost = Post(title: "Третий пост",
                     author: "iStock",
                     description: "The Ultimate Guide to Hex Colors",
                     image: PostImages.thridPostImg,
                     likes: 546,
                     views: 763)

var thirdPostFull = Post(title: "Третий пост",
                     author: "iStock",
                     description: thirdPostText,
                     image: PostImages.thridPostImg,
                     likes: 546,
                     views: 763)

var fourthPost = Post(title: "Четвертый пост",
                      author: "Дима Скворцов",
                      description: "Аксессуары для мобильной съёмки на смартфон",
                      image: PostImages.fourthPostImg,
                      likes: 125,
                      views: 307)

var fourthPostFull = Post(title: "Четвертый пост",
                      author: "Дима Скворцов",
                      description: fourthPostText,
                      image: PostImages.fourthPostImg,
                      likes: 125,
                      views: 307)

var arrayOfPosts: [Post] = [firstPost, secondPost, thirdPost, fourthPost]
var post1: [Post] = [firstPost]
var post2: [Post] = [secondPost]
var post3: [Post] = [thirdPost]
var post4: [Post] = [fourthPost]

struct PostImages {
    static let firstPostImg = UIImage(named: "PostImage_1")!
    static let secondPostImg = UIImage(named: "PostImage_2")!
    static let thridPostImg = UIImage(named: "PostImage_3")!
    static let fourthPostImg = UIImage(named: "PostImage_4")!
}
