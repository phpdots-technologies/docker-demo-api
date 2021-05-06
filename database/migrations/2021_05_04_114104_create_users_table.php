<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('country_id')->unsigned()->nullable();
            $table->foreign('country_id', 'countries_ibfk_1')
                    ->references('id')
                    ->on('countries')
                    ->onUpdate('RESTRICT')
                    ->onDelete('RESTRICT');
            $table->string('api_token',255)->nullable();
            $table->string('firstname',255);
            $table->string('lastname',255);
            $table->string('email',255)->unique();
            $table->string('password',255)->nullable();
            $table->string('address',255);
            $table->string('city',255);
            $table->string('state',255);
            $table->string('zipcode',32);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
