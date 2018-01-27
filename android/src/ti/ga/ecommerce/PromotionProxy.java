package ti.ga.ecommerce;

import ti.ga.TigaModule;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import android.util.Log;
import android.text.TextUtils;

import com.google.android.gms.analytics.ecommerce.Promotion;

@Kroll.proxy(creatableInModule=TigaModule.class)
public class PromotionProxy extends KrollProxy {
    private String LCAT = "ti.ga.PromotionProxy";
    private Promotion promotion;
    private KrollDict descriptor;

    public PromotionProxy() {
        super();
    }

    public void handleCreationDict(KrollDict args) {
        this.descriptor = args;

        this.promotion = new Promotion();
        this.promotion.setId(this.descriptor.getString("id"));
        this.promotion.setName(this.descriptor.getString("name"));
        this.promotion.setCreative(this.descriptor.getString("creative"));
        this.promotion.setPosition(this.descriptor.getString("position"));
    }

    public Promotion getNative() {
        return this.promotion;
    }

    @Kroll.method
    public String toString() {
        String[] keys = {"id", "name", "creative", "position"};
        String[] values = new String[keys.length];

        for (int i = 0; i < keys.length; i++) {
            String key = keys[i];

            values[i] = String.format("%s: %s", key, this.descriptor.getString(key));
        }

        return TextUtils.join("\n", values);
    }
}
