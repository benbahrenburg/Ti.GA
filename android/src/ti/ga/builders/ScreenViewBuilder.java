package ti.ga.builders;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import android.util.Log;
import android.text.TextUtils;

import com.google.android.gms.analytics.HitBuilders;
import com.google.android.gms.analytics.ecommerce.Product;
import com.google.android.gms.analytics.ecommerce.ProductAction;
import com.google.android.gms.analytics.ecommerce.Promotion;

public class ScreenViewBuilder implements DictionaryBuilderInterface {
    private String LCAT = "ti.ga.ScreenViewBuilder";
    private HitBuilders.ScreenViewBuilder builder;

    public ScreenViewBuilder() {
        this.builder = new HitBuilders.ScreenViewBuilder();
    }

    public void addProduct(Product product) {
        this.builder.addProduct(product);
    }

    public void setProductAction(ProductAction action) {
        this.builder.setProductAction(action);
    }

    public void addPromotion(Promotion promotion) {
        this.builder.addPromotion(promotion);
    }

    public void addImpression(Product product, String impressionList) {
        this.builder.addImpression(product, impressionList);
    }

    public HitBuilders.ScreenViewBuilder getNative() {
        return this.builder;
    }
}
