CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8mb4;
USE `test`;

CREATE TABLE `users`
(
    `user_id`  int         NOT NULL AUTO_INCREMENT COMMENT '유저 식별값',
    `username` varchar(30) NOT NULL COMMENT '유저 로그인 아이디',
    `password` varchar(50) NOT NULL COMMENT '유저 패스워드',
    `created_at`   timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `modified_at`  timestamp            DEFAULT NULL COMMENT '수정 일시',
    PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='유저';

INSERT INTO `users` (username, password) VALUES ('user1', 'password1'),('user2', 'password2'), ('user3', 'password3');