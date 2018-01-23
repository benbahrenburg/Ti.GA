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

public class EventBuilder implements DictionaryBuilderInterface {
    private String LCAT = "ti.ga.EventBuilder";
    private HitBuilders.EventBuilder builder;

    public EventBuilder(KrollDict properties) {
        this.builder = new HitBuilders.EventBuilder();
        this.builder.setCategory(properties.getString("name"));
        this.builder.setAction(properties.getString("action"));

        if (properties.containsKey("label")) {
            this.builder.setLabel(properties.getString("label"));
        }

        if (properties.containsKey("value")) {
            this.builder.setValue(Long.valueOf(properties.getInt("value").longValue()));
        }
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

    public HitBuilders.EventBuilder getNative() {
        return this.builder;
    }
}
