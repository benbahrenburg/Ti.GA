package ti.ga.ecommerce;

import ti.ga.TigaModule;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import android.util.Log;
import android.text.TextUtils;

import com.google.android.gms.analytics.ecommerce.ProductAction;

@Kroll.proxy(creatableInModule=TigaModule.class)
public class ProductActionProxy extends KrollProxy {
    private String LCAT = "ti.ga.ProductActionProxy";
    private ProductAction productAction;
    private KrollDict descriptor;

    public ProductActionProxy() {
        super();
    }

    public void handleCreationDict(KrollDict args) {
        this.descriptor = args;

        if (!this.descriptor.containsKey("type")) {
            Log.e(LCAT, "Unable to create a ProductAction. Missing 'type' property in creation dictionary");

            return;
        }

        this.productAction = new ProductAction(this.descriptor.getString("type"));

        if (this.descriptor.containsKey("transaction"))
            this.handleTransaction(this.descriptor.getKrollDict("transaction"));

        if (this.descriptor.containsKey("checkout"))
            this.handleCheckout(this.descriptor.getKrollDict("checkout"));
    }

    public ProductAction getNative() {
        return this.productAction;
    }

    @Kroll.method
    @Kroll.setProperty
    public void setTransaction(KrollDict args) {
        this.descriptor.put("transaction", args);

        this.handleTransaction(this.descriptor.getKrollDict("transaction"));
    }

    @Kroll.method
    @Kroll.setProperty
    public void setCheckout(KrollDict args) {
        this.descriptor.put("checkout", args);

        this.handleCheckout(this.descriptor.getKrollDict("checkout"));
    }

    @Kroll.method
    @Kroll.setProperty
    public void setList(KrollDict args) {
        this.descriptor.put("list", args);

        this.handleList(this.descriptor.getKrollDict("list"));
    }

    private void handleTransaction(KrollDict transaction) {
        this.productAction.setTransactionId(transaction.getString("id"));
        this.productAction.setTransactionAffiliation(transaction.getString("affiliation"));
        this.productAction.setTransactionCouponCode(transaction.getString("coupon"));

        if (transaction.get("tax") != null)
            this.productAction.setTransactionTax(transaction.getDouble("tax"));

        if (transaction.get("revenue") != null)
            this.productAction.setTransactionRevenue(transaction.getDouble("revenue"));

        if (transaction.get("shipping") != null)
            this.productAction.setTransactionShipping(transaction.getDouble("shipping"));
    }

    private void handleCheckout(KrollDict checkout) {
        this.productAction.setCheckoutOptions(checkout.getString("options"));

        if (checkout.get("step") != null)
            this.productAction.setCheckoutStep(checkout.getInt("step"));
    }

    private void handleList(KrollDict list) {
        this.productAction.setProductActionList(list.getString("name"));
        this.productAction.setProductListSource(list.getString("source"));
    }

    @Kroll.method
    public String toString() {
        String[] keys = {"type", "list", "transaction", "checkout"};
        String[] values = new String[keys.length];

        for (int i = 0; i < keys.length; i++) {
            String key = keys[i];

            values[i] = String.format("%s: %s", key, this.descriptor.getString(key));
        }

        return TextUtils.join("\n", values);
    }
}
