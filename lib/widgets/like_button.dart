import 'package:like_button/like_button.dart';
import 'package:urbanlink_project/models/post/post.dart';
import 'package:urbanlink_project/database/post_database_service.dart';
import 'package:flutter/material.dart';

LikeButton postDislikeButton(Post post) {
  return LikeButton(
    circleColor:
    const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
    bubblesColor: const BubblesColor(
      dotPrimaryColor: Color(0xff33b5e5),
      dotSecondaryColor: Color(0xff0099cc),
    ),
    likeBuilder: (bool isLiked) {
      return Icon(
        Icons.thumb_down,
        color: isLiked ? Colors.pinkAccent : Colors.grey,
      );
    },
    likeCount: post.postDislikeCount,
    countBuilder: (int? count, bool isLiked, String text) {
      final ColorSwatch<int> color =
      isLiked ? Colors.pinkAccent : Colors.grey;
      Widget result;
      if (count == 0) {
        result = Text(
          "unlike",
          style: TextStyle(color: color),
        );
      } else {
        result = Text(
          text,
          style: TextStyle(color: color),
        );
      }
      return result;
    },
    onTap: (isDisLiked) async {
      if (isDisLiked) {
        post.postDislikeCount--;
        PostDatabaseService.decreasePostDislikeCount(postId: post.postId);
      } else {
        post.postDislikeCount++;
        PostDatabaseService.increasePostDislikeCount(postId: post.postId);
      }
      return !isDisLiked;
    },
  );
}

LikeButton postLikeButton(Post post) {
  return LikeButton(
    circleColor:
    const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
    bubblesColor: const BubblesColor(
      dotPrimaryColor: Color(0xff33b5e5),
      dotSecondaryColor: Color(0xff0099cc),
    ),
    likeBuilder: (bool isLiked) {
      return Icon(
        Icons.favorite,
        color: isLiked ? Colors.pinkAccent : Colors.grey,
      );
    },
    likeCount: post.postLikeCount,
    countBuilder: (int? count, bool isLiked, String text) {
      final ColorSwatch<int> color =
      isLiked ? Colors.pinkAccent : Colors.grey;
      Widget result;
      if (count == 0) {
        result = Text(
          "love",
          style: TextStyle(color: color),
        );
      } else {
        result = Text(
          text,
          style: TextStyle(color: color),
        );
      }
      return result;
    },
    onTap: (isLiked) async {
      if (isLiked) {
        post.postLikeCount--;
        PostDatabaseService.decreasePostLikeCount(postId: post.postId);
      } else {
        post.postLikeCount++;
        PostDatabaseService.increasePostLikeCount(postId: post.postId);
      }
      return !isLiked;
    },
  );
}