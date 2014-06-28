Description
===========

Chef cookbook providing ini file update helper

Requirements
------------
No requiremenst.

Attributes
----------
No attributes used.

Usage
-----
Just define this cookbook as a dependency and use the update_ini definition.

e.g.

```ruby
update_ini "/etc/php5/apache2/php.ini" do
    settings {
        "max_execution_time" => "300",
        "max_input_time" => "600",
        "max_input_vars" => "2100",
        "post_max_size" => "5M",
        "setting_to_remove" => nil
    }
end
```

Use ```nil``` as value to remove setting from the ini file.

License and Authors
-------------------
Author: Endre Fejes (fejese@fejese.com)

Copyright: 2014, Endre Fejes

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

