public class ProductService
{
    private ProductContext _context;

    public ProductService(ProductContext context)
    {
        _context = context;
    }

    public List<Category> GetCategories()
    {
        return _context.Categories.ToList();
    }

    public List<Product> GetProducts()
    {
        return _context.Products.ToList();
    }

    public List<Product> GetProductsByName(string searchKeyword)
    {
        return _context.Products
                       .Where(p => p.ProductName!.Contains(searchKeyword))
                       .ToList();
    }

    public List<Product> GetProductsByCategory(int catId)
    {
        if (catId == 0)  // get all products
        {
            return _context.Products.ToList();
        }
        else  // get products by category id
        {
            return _context.Products
                           .Where(p => p.CategoryId == catId)
                           .ToList();
        }
    }
}
