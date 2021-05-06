<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Country;

class CountryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        if(Country::count() == 0){
        	$countries = ["Canada","Japan","United States","United Kingdom"];
        	foreach($countries as $country){
        		$model = new Country;
        		$model->create(["title" => $country]);
        	}
        }
    }
}
