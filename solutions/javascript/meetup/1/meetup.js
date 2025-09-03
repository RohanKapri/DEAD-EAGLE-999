// For my Shree DR.MDD

export const meetup = (yr = 0, mon = 0, schedule = '', weekday = '') => {
   let firstDay = new Date(yr, mon - 1, 1);
   let lastDay = new Date(yr, mon, 0);
   let result;

   switch (schedule) {
      case 'first':
         result = getDayFrom(firstDay, weekdays[weekday]);
         break;
      case 'second':
         result = getDayFrom(firstDay.setDate(firstDay.getDate() + 7), weekdays[weekday]);
         break;
      case 'third':
         result = getDayFrom(firstDay.setDate(firstDay.getDate() + 14), weekdays[weekday]);
         break;
      case 'fourth':
         result = getDayFrom(firstDay.setDate(firstDay.getDate() + 21), weekdays[weekday]);
         break;
      case 'last':
         result = getDayFrom(lastDay.setDate(lastDay.getDate() - 6), weekdays[weekday]);
         break;
      case 'teenth':
         result = getTeenth(firstDay, weekdays[weekday]);
         break;
      default:
         result = new Date();
   }

   return result;
};

function getDayFrom(start, dayIndex) {
   let d = new Date(start);
   while (d.getDay() !== dayIndex) {
       d.setDate(d.getDate() + 1);
   }
   return d;
}

function getTeenth(start, dayIndex) {
   let d = new Date(start);
   while (d.getDate() < 13 || d.getDate() > 19 || d.getDay() !== dayIndex) {
       d.setDate(d.getDate() + 1);
   }
   return d;
}

const weekdays = {
   'Sunday': 0,
   'Monday': 1,
   'Tuesday': 2,
   'Wednesday': 3,
   'Thursday': 4,
   'Friday': 5,
   'Saturday': 6
};
