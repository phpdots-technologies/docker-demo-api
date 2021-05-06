<?php

use Illuminate\Database\Seeder;
use Database\Seeders\CountryTableSeeder;
use Database\Seeders\UserTableSeeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
            CountryTableSeeder::class,
            UserTableSeeder::class
        ]);    
    }
}
