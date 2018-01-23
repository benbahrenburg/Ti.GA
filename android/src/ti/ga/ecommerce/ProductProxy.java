package ti.ga.ecommerce;

import ti.ga.TigaModule;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import android.util.Log;
import android.text.TextUtils;

import com.google.android.gms.analytics.ecommerce.Product;


@Kroll.proxy(creatableInModule=TigaModule.class)
public class ProductProxy extends KrollProxy {
    private String LCAT = "ti.ga.ProductProxy";
    private Product product;
    private KrollDict descriptor;

    public ProductProxy() {
        super();

        this.product = new Product();
    }

    public void handleCreationDict(KrollDict args) {
        this.descriptor = args;

        this.product.setId(this.descriptor.getString("id"));
	    this.product.setName(this.descriptor.getString("name"));
	    this.product.setCategory(this.descriptor.getString("category"));
	    this.product.setBrand(this.descriptor.getString("brand"));
	    this.product.setVariant(this.descriptor.getString("variant"));
        this.product.setCouponCode(this.descriptor.getString("coupon"));

        if (this.descriptor.containsKey("position"))
            this.product.setPosition(this.descriptor.getInt("position"));

        if (this.descriptor.containsKey("quantity"))
            this.product.setQuantity(this.descriptor.getInt("quantity"));

        if (this.descriptor.containsKey("price"))
            this.product.setPrice(this.descriptor.getDouble("price"));

        // Handling custom metrics and dimensions for given product
        this.handleCustomDimensions(this.descriptor.getKrollDict("customDimensions"));
        this.handleCustomMetrics(this.descriptor.getKrollDict("customMetrics"));
    }

    public Product getNative() {
        return this.product;
    }

    @Kroll.method
    public String toString() {
        String[] keys = {"id", "name", "category", "brand", "variant", "position", "coupon", "price", "quantity", "customDimensions", "customMetrics"};
        String[] values = new String[keys.length];

        for (int i = 0; i < keys.length; i++) {
            String key = keys[i];

            values[i] = String.format("%s: %s", key, this.descriptor.getString(key));
        }

        return TextUtils.join("\n", values);
    }

    private void handleCustomDimensions(KrollDict customDimensions) {
        if (customDimensions == null)
            return;

        for (String key : customDimensions.keySet()) {
            int index = Integer.parseInt(key);
            String value = customDimensions.getString(key);

            if (index > 0)
                this.product.setCustomDimension(index, value);
        }
    }

    private void handleCustomMetrics(KrollDict customMetrics) {
        if (customMetrics == null)
            return;

        for (String key : customMetrics.keySet()) {
            int index = Integer.parseInt(key);
            int value = customMetrics.getInt(key);

            if (index > 0)
                this.product.setCustomMetric(index, value);
        }
    }
}
