set @dealerNum := '70044';
set @bufferDays = 2;

select a3.*, (frequency - daysSince) daysBehind from
(
    select a2.*,
    IF(a2.latestCompletedDate > 0, datediff(now(), a2.latestCompletedDate) ,datediff(now(), a2.dateReceived)) daysSince
    from 
    (
        select *, max(completedDate) latestCompletedDate
        from 
        (
            select inv.*, mcl.checkListId, cl.checkListDesc, cl.frequency, ia.completedDate  from inventory inv left join model_checkList mcl on (inv.modelLineCode = mcl.modelLineCode)
            left join inventoryActions ia on (ia.checkListId = mcl.checkListId and ia.vin = inv.vin)
            left join checkList cl on (cl.checkListId = mcl.checkListId)
            where inv.dealerNum = @dealerNum
            -- and inv.vin in ('JN1CV7AP5HM640540', 'JN1EV7AP3HM732738', 'JN1EV7AP2HM736876', 'JN1EV7AP5HM730649') 
            order by vin, mcl.checkListId
        ) a1
        group by a1.vin, a1.checkListId
    ) a2
) a3 where (frequency - daysSince) < @bufferDays;