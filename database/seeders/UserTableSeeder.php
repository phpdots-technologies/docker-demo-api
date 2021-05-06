<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Country;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        if(User::count() == 0){
            $country = Country::first();
            $model = new User;
            $model->country_id = $country ? $country->id:NULL;
            $model->firstname = "John";
            $model->lastname = "Smith";
            $model->email = "john.smith@gmail.com";
            $model->password = NULL;
            $model->address = "Street no 3";
            $model->city = "Athabasca";
            $model->state = "Alberta";
            $model->zipcode = "T9S";
            $model->save();
        }
    }
}
