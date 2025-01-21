%dw 2.0
output application/json
---
{
    paymensCurrency: payload.paymens.currency,
    paymensId: payload.paymens.paymensId,
    paymensTime: payload.paymens.paymensTime,
    items: payload.items map ((item) -> {
        name: item.name,
        count: item.count,
        id: item.id,
        price: item.price * item.count,
        warehouseId: payload.address.pvzId
    })
}
