package ti.ga;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import android.util.Log;
import android.text.TextUtils;

import ti.ga.builders.DictionaryBuilderInterface;
import ti.ga.builders.EventBuilder;
import ti.ga.builders.ScreenViewBuilder;

import ti.ga.ecommerce.ProductProxy;
import ti.ga.ecommerce.ProductActionProxy;
import ti.ga.ecommerce.PromotionProxy;

@Kroll.proxy(creatableInModule=TigaModule.class)
public class DictionaryBuilderProxy extends KrollProxy {
    private String LCAT = "ti.ga.DictionaryBuilderProxy";
    private DictionaryBuilderInterface builder;

    public DictionaryBuilderProxy() {
        super();
    }

    public void handleCreationDict(KrollDict args) {
        if (args.containsKey("type") && args.getString("type").equals(TigaModule.BUILDER_TYPE_EVENT)) {
            this.builder = new EventBuilder(args.getKrollDict("options"));
        } else {
            this.builder = new ScreenViewBuilder();
        }
    }

    @Kroll.method
    public void addProduct(ProductProxy product) {
        this.builder.addProduct(product.getNative());
    }

    @Kroll.method
    public void setProductAction(ProductActionProxy action) {
        this.builder.setProductAction(action.getNative());
    }

    @Kroll.method
    public void addPromotion(PromotionProxy promotion) {
        this.builder.addPromotion(promotion.getNative());
    }

    @Kroll.method
    public void addImpression(ProductProxy product, String impressionList) {
        this.builder.addImpression(product.getNative(), impressionList);
    }

    public DictionaryBuilderInterface getNative() {
        return this.builder;
    }
}
