<?php

namespace App\Controller;

use App\Entity\Media;
use App\Entity\Member;
use App\Model\MemberRepository;
use App\Model\MediaRepository;

class AppController extends Controller
{

    const email_pattern = "/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$/i";
    const username_pattern = "/^[a-zA-Z0-9]{5,}$/";
    const pass_pattern = "/^.{8,}$/";
    const phone_pattern = "/^[0-9]{10}+$/";
    const fullname_pattern = "/^([a-zA-Z' ]+)$/";

    public function index()
    {
        if (isset($_POST['db_execute']) && !empty($_POST['db_execute'])) {
            if (is_object($this->getDB()->getServer())) {

                if ($_POST['db_execute'] === '1') {
                    $this->assign('flash', ['type' => 'success', 'message' => 'Connection succeeded']);
                }
                if ($_POST['db_execute'] === '2') {
                    $creating = $this->getDB()->createDatabase();

                    if ($creating === true) {
                        $this->assign('flash', ['type' => 'success', 'message' => 'Database created successfully']);
                    } else {
                        $this->assign('flash', ['type' => 'danger', 'message' => $creating]);
                    }
                }
                if ($_POST['db_execute'] === '3' && is_object($this->getDB()->getConnection())) {
                    $member = $this->getDB()->createTableMember();
                    $media = $this->getDB()->createTableMedia();

                    if ($member === true && $media === true) {
                        $this->assign('flash', ['type' => 'success', 'message' => 'Tables created successfully']);
                    } else {
                        $this->assign('flash', ['type' => 'danger', 'message' => 'Tables cannot be created or all ready created']);
                    }
                } else if ($_POST['db_execute'] === '3' && !is_object($this->getDB()->getConnection())) {
                    $this->assign('flash', ['type' => 'danger', 'message' => $this->getDB()->getConnection()]);
                }
            } else {
                $this->assign('flash', ['type' => 'danger', 'message' => $this->getDB()->getServer()]);
            }
        }

        $this->display('home.tpl');
    }

    public function list()
    {
        $repository = new MemberRepository();

        $members = $repository->getAll();

        $this->display('list.tpl', ['members' => $members]);
        //unset($_SESSION['flash']);
    }

    public function add()
    {
        if (isset($_POST['add_row'])) {

            $member = new Member();

            foreach ($_POST as $key => $value) {
                switch ($key) {
                    case 'full_name':
                        if (preg_match(self::fullname_pattern, $value)) {
                            $member->setFullName($value);
                        } else {
                            $this->assign('flash', ['type' => 'danger', 'message' => 'Invalid name given.']);
                            $this->display('add.tpl');
                            exit;
                        }
                        break;
                    case 'birth_date':
                        if ($this->validateAge($value)) {
                            $member->setBirthDate($value);
                        } else {
                            $this->assign('flash', ['type' => 'danger', 'message' => 'You Must be 18 or Older.']);
                            $this->display('add.tpl');
                            exit;
                        }
                        break;
                    case 'username':
                        if (preg_match(self::username_pattern, $value)) {
                            $member->setUsername($value);
                        } else {
                            $this->assign('flash', ['type' => 'danger', 'message' => 'Invalid username.']);
                            $this->display('add.tpl');
                            exit;
                        }
                        break;
                    case 'phone':
                        if (preg_match(self::phone_pattern, $value)) {
                            $member->setPhone(trim($value));
                        } else {
                            $this->assign('flash', ['type' => 'danger', 'message' => 'Invalid phone.']);
                            $this->display('add.tpl');
                            exit;
                        }
                        break;
                    case 'email':
                        // filter_var($value, FILTER_VALIDATE_EMAIL)
                        if (preg_match(self::email_pattern, $value)) {
                            $member->setEmail(trim($value));
                        } else {
                            $this->assign('flash', ['type' => 'danger', 'message' => 'Invalid Email.']);
                            $this->display('add.tpl');
                            exit;
                        }
                        break;
                    case 'password':
                        if (preg_match(self::pass_pattern, $value)) {
                            if ($value === $_POST['password_repeat']) {
                                $member->setPassword($this->hashThePass($value));
                            } else {
                                $this->assign('flash', ['type' => 'danger', 'message' => 'Passwords not match.']);
                                $this->display('add.tpl');
                                exit;
                            }
                        } else {
                            $this->assign('flash', ['type' => 'danger', 'message' => 'Password not strong enough / Password too short.']);
                            $this->display('add.tpl');
                            exit;
                        }
                    case 'address':
                        $member->setAddress($value);
                        break;
                    case 'city':
                        $member->setCity(trim($value));
                        break;
                    case 'country':
                        $member->setCountry(trim($value));
                        break;
                    case 'zip':
                        $member->setZip(trim($value));
                        break;
                    default:
                        break;
                }
            }

            $repository = new MemberRepository();

            $result = $repository->flush($member);

            if ($result && !empty($_FILES["photo"]["name"])) {
                $media = new Media();
                $mediaRepository = new MediaRepository();
                $imgData = file_get_contents($_FILES['photo']['tmp_name']);
                $imgName = basename($_FILES["photo"]["name"]);
                $imgType = pathinfo($imgName, PATHINFO_EXTENSION);

                $media->setName($imgData);
                $media->setType($imgType);
                $media->setMember($result);

                $mediaRepository->flush($media);
            }

            if ($result) {
                $this->assign('flash', ['type' => 'success', 'message' => 'New Row Added. <a href="/list">Go To List</a>']);
            }

            //$_SESSION['flash'] = 'New Row Added.';
            //header('Location:/list');

        }

        $this->display('add.tpl');
    }

    public function error()
    {
        echo '404';
    }

    public function editMember(int $id)
    {
        $rep = new MemberRepository();
        $member = $rep->getOneById($id);

        if (isset($_POST['edit_row'])) {
            var_dump($_POST);
        }

        if ($member) {
            $this->assign('member', $member);

            $this->display('add.tpl');
        }
        else
        {
            $this->error();
        }


    }

    public function deleteMember(int $id)
    {
    }

    private function validateAge($date, $age = 18)
    {
        $birthday = date("d-m-Y", strtotime($date));

        // $birthday can be UNIX_TIMESTAMP or just a string-date.
        if (is_string($birthday)) {
            $birthday = strtotime($birthday);
        }

        // check
        // 31536000 is the number of seconds in a 365 days year.
        if (time() - $birthday < $age * 31536000) {
            return false;
        }

        return true;
    }

    private function hashThePass($pass)
    {
        $options = [
            'cost' => 12,
        ];
        return password_hash($pass, PASSWORD_BCRYPT, $options);
    }
}
