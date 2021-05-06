<?php

namespace App\Http\Controllers;
use App\Models\Country;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class ApiController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function getCountry(){
        return 
        [
            'status' => 1,
            'message' => 'Data',
            'data' => Country::orderBy("title")->select("title","id")->get()->toArray()
        ];
    }

    public function getUser($id){
        $user = User::find($id);
        if($user){
            return 
            [
                'status' => 1,
                'message' => 'Data',
                'data' => [
                    'id' => $user->id,
                    'firstname' => $user->firstname,
                    'lastname' => $user->lastname,
                    'email' => $user->email,
                    'country_id' => $user->country_id,
                    'address' => $user->address,
                    'city' => $user->city,
                    'state' => $user->state,
                    'zipcode' => $user->zipcode,
                ]
            ];
        }else{
            return 
            [
                'status' => 0,
                'message' => 'User not found',
                'data' => []
            ];
        }
    }


    public function updateUser(Request $request, $id){
        $user = User::find($id);
        if($user){
            $status = 1;
            $message = "Profile has been updated successfully.";

            $rules = [
                'firstname' => 'required',
                'lastname' => 'required',
                'country_id' => 'required|exists:countries,id',
                'email' => 'required|email|unique:users,email,'.$id,
                'address' => 'required',
                'city' => 'required',
                'state' => 'required',
                'zipcode' => 'required',
            ];

            $errMessages = [
                'country_id.required' => "Country field is required.",
                'country_id.invalid' => "Country field is invalid.",
            ];

            $input = $request->all();
            $validator = Validator::make($input, $rules, $errMessages);
            if ($validator->fails()){
                $messages = $validator->messages();
                return ['status' => 0,"message" => $messages];
            }else{
                $user->update($input);
            }

            return[
                'status' => $status,
                'message' => $message,
                'data' => []
            ];
        }else{
            return[
                'status' => 0,
                'message' => 'User not found',
                'data' => []
            ];
        }
    }
}
