import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.firebase.ui.database.FirebaseRecyclerAdapter
import com.firebase.ui.database.FirebaseRecyclerOptions

class TodoAdapter(options: FirebaseRecyclerOptions<Todo>) : FirebaseRecyclerAdapter<Todo, TodoAdapter.MyViewHolder>(options)  {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        val inflater  = LayoutInflater.from(parent.context)
        return MyViewHolder(inflater, parent)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int, model: Todo) {
        holder.txtTodo.text = model.msg
    }

    class MyViewHolder(inflater: LayoutInflater, parent: ViewGroup) : RecyclerView.ViewHolder(inflater.inflate(R.layout.row_layout, parent, false)) {
        val txtTodo: TextView = itemView.findViewById(R.id.txtTodo)
    }
}
