<?php

require_once dirname(__DIR__) . '/vendor/autoload.php';

use App\Controller\AppController;
use App\Controller\PostController;
use App\Controller\AuthorController;

$request = $_SERVER['REQUEST_URI'];
$app = new AppController();
$post = new PostController();
$author = new AuthorController();

if ($_GET) {
    switch ($request) {
        case '/author/edit?id=' . $_GET['id']:
            if (preg_match('/^\d+$/', $_GET['id'])) {
                $author->save($_GET['id']);
            } else {
                echo 'invalid ID';
            }
            break;
        case '/author/delete?id=' . $_GET['id']:
            if (preg_match('/^\d+$/', $_GET['id'])) {
                $author->deleteAuthor($_GET['id']);
            } else {
                echo 'invalid ID';
            }
            break;
        default:
            http_response_code(404);
            $app->error();
            break;
    }
} else {

    switch ($request) {
        case '/home':
        case '/':
            $app->index();
            break;
        case '/authors':
            $author->list();
            break;
        case '/author/new':
            $author->save();
            break;
        case '/posts':
            $post->list();
            break;
        default:
            http_response_code(404);
            $app->error();
            break;
    }
}
