package ti.ga.builders;

import com.google.android.gms.analytics.HitBuilders;
import com.google.android.gms.analytics.ecommerce.Product;
import com.google.android.gms.analytics.ecommerce.ProductAction;
import com.google.android.gms.analytics.ecommerce.Promotion;

public interface DictionaryBuilderInterface {
    public void addProduct(Product product);
    public void setProductAction(ProductAction action);
    public void addPromotion(Promotion promotion);
    public void addImpression(Product product, String impressionList);
}
