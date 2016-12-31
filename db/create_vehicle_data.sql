# Nalley Infiniti 71304
# Roswell Infiniti 70044
insert into model values ('Q5', 'Q50');
insert into model values ('X8', 'QX80');


insert into checkList values ('CheckBattery', 'Check Battery', 30);
insert into checkList values ('MoveCar', 'Move Car', 30);
insert into checkList values ('CheckAudio', 'Check Audio Systems', 30);
insert into checkList values ('WashCar', 'Wash Car', 60);
insert into checkList values ('CheckFluids', 'Check Fluids', 60);
insert into checkList values ('CheckAC', 'Check AC', 60);
insert into checkList values ('RotateTires', 'Rotate Tires', 60);
insert into checkList values ('DeepClean', 'Deep Clean', 90);				


insert into model_checkList values ('Q5', 'CheckBattery');
insert into model_checkList values ('Q5', 'WashCar');
insert into model_checkList values ('Q5', 'CheckAC');
insert into model_checkList values ('Q5', 'DeepClean');


insert into model_checkList values ('X8', 'MoveCar');
insert into model_checkList values ('X8', 'CheckAudio');
insert into model_checkList values ('X8', 'CheckBattery');
insert into model_checkList values ('X8', 'CheckFluids');



insert into inventoryActions values ('JN1CV7AP5HM640540', 'CheckBattery', '2016-11-16');
insert into inventoryActions values ('JN1CV7AP5HM640540', 'CheckBattery', '2016-12-15');
insert into inventoryActions values ('JN1CV7AP5HM640540', 'CheckAC', '2016-11-16');

insert into inventoryActions values ('JN1EV7AP3HM732738', 'CheckBattery', '2016-11-01');
insert into inventoryActions values ('JN1EV7AP3HM732738', 'CheckBattery', '2016-12-20');
insert into inventoryActions values ('JN1EV7AP3HM732738', 'DeepClean', '2016-12-10');



# Key Features

# --------------
# Get checklist to be performed for a VIN
# Input: Last 6 digits of VIN
# Output: inventory Info and list of checklist items
select c.checkListId, c.checkListDesc, c.frequency from model_checkList mc 
join checkList c on (mc.checkListId = c.checkListId)
where mc.modelLineCode =
(select modelLineCode from inventory where vin = 'JN1CV7AP5HM640540' and dealerNum = '70044')

# --------------
# Get Tasks Performed on the Vehicle 
# Input: Last 6 digits of VIN
# Output: Actions Performed on the VIN
# --------------
select * from inventoryActions ia
join checkList c on (ia.checkListId = c.checkListId)
where ia.vin = 'JN1CV7AP5HM640540'

# --------------
# Set Tasks Performed on the Vehicle 
# Input: Last 6 digits of VIN
# Output: Actions Performed on the VIN

# Shridhar Dont forget API will not work without body mapping template
{
  "vin": $input.params('vin'),
  "dealerNum": $input.params('dealerNum')
}

https://wo53w3qno8.execute-api.us-east-1.amazonaws.com/test/inventory/70044
https://wo53w3qno8.execute-api.us-east-1.amazonaws.com/test/checklist/70044/JN1CV7AP8HM640077











