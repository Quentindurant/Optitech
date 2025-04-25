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
        Schema::create('interventions', function (Blueprint $table) {
            $table->id();
            $table->string('title', 200);
            $table->text('description')->nullable();
            $table->enum('status', ['pending', 'in_progress', 'completed', 'cancelled'])->default('pending');
            $table->dateTime('start_date');
            $table->dateTime('end_date')->nullable();
            $table->integer('rating')->nullable()->check('rating between 1 and 5');
            $table->text('comment')->nullable();
            $table->foreignId('partner_id')->constrained()->onDelete('restrict')->onUpdate('cascade');
            $table->foreignId('client_id')->constrained()->onDelete('restrict')->onUpdate('cascade');
            $table->foreignId('user_id')->constrained()->onDelete('restrict')->onUpdate('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('interventions');
    }
};
