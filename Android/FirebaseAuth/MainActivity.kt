import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.firebase.ui.auth.AuthUI
import com.firebase.ui.auth.FirebaseAuthUIActivityResultContract
import com.firebase.ui.auth.data.model.FirebaseAuthUIAuthenticationResult
import com.firebase.ui.database.FirebaseRecyclerOptions
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.database.FirebaseDatabase

class MainActivity : AppCompatActivity() {

    private var adapter: TodoAdapter? = null
    private val signInLauncher = registerForActivityResult(FirebaseAuthUIActivityResultContract()) {
        result -> this.onSignInResult(result)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // Sign out the user every time the activity is created.
        // This ensures the login screen is always shown on app start.
        FirebaseAuth.getInstance().signOut()
    }

    private fun createSignInIntent() {
        val providers = arrayListOf(AuthUI.IdpConfig.EmailBuilder().build())

        val signInIntent = AuthUI.getInstance()
            .createSignInIntentBuilder()
            .setAvailableProviders(providers)
            .build()

        signInLauncher.launch(signInIntent)
    }

    private fun onSignInResult(result: FirebaseAuthUIAuthenticationResult) {
        if (result.resultCode == RESULT_OK) {
            // Successfully signed in
            val user = FirebaseAuth.getInstance().currentUser
            loadUI(user)
        } else {
            createSignInIntent()
        }
    }

    private fun loadUI(user: FirebaseUser?) {
        val uid: String? = user?.uid
        val query = FirebaseDatabase.getInstance().reference.child("todo/$uid")

        val btnTodo : Button = findViewById(R.id.btnSave)
        val editTodo : EditText = findViewById(R.id.editTodo)
        val rView: RecyclerView = findViewById(R.id.rView)

        val options = FirebaseRecyclerOptions.Builder<Todo>().setQuery(query, Todo::class.java).build()
        adapter = TodoAdapter(options)

        rView.layoutManager = LinearLayoutManager(this)
        rView.adapter = adapter
        adapter?.startListening()

        btnTodo.setOnClickListener {
            val msg : String =editTodo.text.toString()
            val email: String? = user?.email
            val myTodo = Todo(email, msg)
            FirebaseDatabase.getInstance().reference.child("todo/$uid").push().setValue(myTodo)
        }
    }

    override fun onStart() {
        super.onStart()
        val currentUser = FirebaseAuth.getInstance().currentUser

        if (currentUser == null) {
            // No user is signed in, launch the sign-in flow
            createSignInIntent()
        } else {
            // User is signed in, load the main UI
            loadUI(currentUser)
        }

        adapter?.startListening() // start listening if user is already signed in
    }

    override fun onStop() {
        super.onStop()
        adapter?.stopListening()
    }
}
