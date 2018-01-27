package ti.ga.ecommerce;

import ti.ga.TigaModule;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import android.util.Log;
import android.text.TextUtils;

import com.google.android.gms.analytics.HitBuilders.ScreenViewBuilder;
import com.google.android.gms.analytics.ecommerce.Product;
import com.google.android.gms.analytics.ecommerce.ProductAction;

@Kroll.proxy(creatableInModule=TigaModule.class)
public class ScreenViewBuilderProxy extends KrollProxy {
    private String LCAT = "ti.ga.ScreenViewBuilderProxy";
    private ScreenViewBuilder screenViewBuilder;

    public ScreenViewBuilderProxy() {
        super();

        this.screenViewBuilder = new ScreenViewBuilder();
    }

    @Kroll.method
    public void addProduct(ProductProxy product) {
        this.screenViewBuilder.addProduct(product.getNative());
    }

    @Kroll.method
    public void addProductAction(ProductActionProxy action) {
        this.screenViewBuilder.setProductAction(action.getNative());
    }

    @Kroll.method
    public void addPromotion(PromotionProxy promotion) {
        this.screenViewBuilder.addPromotion(promotion.getNative());
    }

    @Kroll.method
    public void addImpression(ProductProxy product, String impressionList) {
        this.screenViewBuilder.addImpression(product.getNative(), impressionList);
    }

    public ScreenViewBuilder getNative() {
        return this.screenViewBuilder;
    }
}
