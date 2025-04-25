<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('intervention_logs', function (Blueprint $table) {
            $table->id();
            $table->string('type', 50);
            $table->timestamp('timestamp')->useCurrent();
            $table->string('location', 255)->nullable();
            $table->foreignId('intervention_id')->constrained()->onDelete('cascade')->onUpdate('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('intervention_logs');
    }
};
