package com.company.cubavisionclinic.web.product;

import com.company.cubavisionclinic.entity.Product;
import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.gui.ComponentsHelper;
import com.haulmont.cuba.gui.components.*;
import com.haulmont.cuba.gui.components.actions.CreateAction;
import com.haulmont.cuba.gui.components.actions.EditAction;
import com.haulmont.cuba.gui.components.actions.RemoveAction;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.gui.data.DataSupplier;
import com.haulmont.cuba.gui.data.Datasource;

import javax.annotation.Nullable;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.ByteArrayInputStream;
import java.util.Collections;
import java.util.Map;
import java.util.UUID;
import com.haulmont.cuba.core.entity.IdProxy;
import com.haulmont.cuba.gui.xml.layout.ComponentsFactory;

public class ProductBrowse extends AbstractLookup {

    private static final String IMAGE_CELL_HEIGHT = "150px";

    @Inject
    private CollectionDatasource<Product, IdProxy> productsDs;

    @Inject
    private Datasource<Product> productDs;

    @Inject
    private Table<Product> productsTable;

    @Inject
    private BoxLayout lookupBox;

    @Inject
    private BoxLayout actionsPane;

    @Inject
    private FieldGroup fieldGroup;
    @Inject
    private TabSheet tabSheet;
    
    @Named("productsTable.remove")
    private RemoveAction productsTableRemove;
    
    @Inject
    private DataSupplier dataSupplier;

    @Inject
    private ComponentsFactory componentsFactory;

    @Inject
    private Embedded productImage;

    private boolean creating;

    @Override
    public void init(Map<String, Object> params) {
        productImage.resetSource();

        productsDs.addItemChangeListener(e -> {
            if (e.getItem() != null) {
                Product reloadedItem = dataSupplier.reload(e.getDs().getItem(), productDs.getView());
                productDs.setItem(reloadedItem);

                generateImage(productDs.getItem(), null, productImage);
            }
        });
        
        productsTable.addAction(new CreateAction(productsTable) {
            @Override
            protected void internalOpenEditor(CollectionDatasource datasource, Entity newItem, Datasource parentDs, Map<String, Object> params) {
                productsTable.setSelected(Collections.emptyList());
                productDs.setItem((Product) newItem);
                enableEditControls(true);

                productImage.resetSource();
            }
        });

        productsTable.addAction(new EditAction(productsTable) {
            @Override
            protected void internalOpenEditor(CollectionDatasource datasource, Entity existingItem, Datasource parentDs, Map<String, Object> params) {
                if (productsTable.getSelected().size() == 1) {
                    enableEditControls(false);
                }
            }
        });
        
        productsTableRemove.setAfterRemoveHandler(removedItems -> productDs.setItem(null));
        
        disableEditControls();
    }

    public void save() {
        getDsContext().commit();

        Product editedItem = productDs.getItem();
        if (creating) {
            productsDs.includeItem(editedItem);
        } else {
            productsDs.updateItem(editedItem);
        }
        productsTable.setSelected(editedItem);

        disableEditControls();
    }

    public void cancel() {
        Product selectedItem = productsDs.getItem();
        if (selectedItem != null) {
            Product reloadedItem = dataSupplier.reload(selectedItem, productDs.getView());
            productsDs.setItem(reloadedItem);
        } else {
            productDs.setItem(null);
        }

        disableEditControls();
    }

    private void enableEditControls(boolean creating) {
        this.creating = creating;
        initEditComponents(true);
        fieldGroup.requestFocus();
    }

    private void disableEditControls() {
        initEditComponents(false);
        productsTable.requestFocus();
    }

    private void initEditComponents(boolean enabled) {
        ComponentsHelper.walkComponents(tabSheet, (component, name) -> {
            if (component instanceof FieldGroup) {
                ((FieldGroup) component).setEditable(enabled);
            } else if (component instanceof Table) {
                ((Table) component).getActions().stream().forEach(action -> action.setEnabled(enabled));
            }
        });
        actionsPane.setVisible(enabled);
        lookupBox.setEnabled(!enabled);
    }

    public Component generateProductImageCell(Product entity) {
		return generateImage(entity, IMAGE_CELL_HEIGHT, null);
    }

    @Nullable
    private Embedded generateImage(Product product, String height, Embedded displayComponent) {
        if (product == null || product.getProductImage() == null) {
            if (displayComponent != null)
                displayComponent.resetSource();
            return null;
        }

        Embedded embedded = displayComponent;
        if (embedded == null)
            embedded = (Embedded) componentsFactory.createComponent(Embedded.NAME);

        embedded.setSource(product.getProductName(), new ByteArrayInputStream(product.getProductImage()));
        if (height != null)
            embedded.setHeight(height);

        return embedded;
    }
}