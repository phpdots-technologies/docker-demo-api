<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * @property int $id
 * @property string $title
 */
class Country extends Model
{
    /**
     * @var array
     */
    protected $fillable = ['title'];
}
