{extends file="base.tpl"}
{$title = 'Add New Row'}
{$countries = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"]}
{block name=content}
  {if isset($member)}
    <h1 class="fw-bold h2">Edit Member:</h1>
    {else}
    <h1 class="fw-bold h2">Add Member:</h1>
  {/if}
    <div class="row p-3">
      <div class="col-lg-12">
        <form class="row g-3" method="POST" action="" enctype="multipart/form-data">
          <div class="col-md-6">
            <label for="inputPhoto" class="form-label">Photo</label>
            <input type="file" name="photo" class="form-control" id="inputPhoto">
          </div>
          <div class="col-md-6">
            <label for="inputFullName" class="form-label">Full Name</label>
            <input type="text" name="full_name" class="form-control" id="inputFullName" {if isset($member)}value="{$member->getFullName()}"{/if}>
          </div>
          <div class="col-md-6">
            <label for="inputUsername" class="form-label">Username</label>
            <input type="text" name="username" class="form-control" id="inputUsername" {if isset($member)}value="{$member->getUsername()}"{/if} required>
          </div>
          <div class="col-md-6">
            <label for="inputBirthDate" class="form-label">Birth Date</label>
            <input type="date" name="birth_date" class="form-control" id="inputBirthDate" {if isset($member)}value="{$member->getBirthDate()}"{/if} required>
          </div>
          <div class="col-md-6">
            <label for="inputEmail" class="form-label">Email</label>
            <input type="email" name="email" class="form-control" id="inputEmail" {if isset($member)}value="{$member->getEmail()}"{/if} required>
          </div>
          <div class="col-md-6">
            <label for="inputPhone" class="form-label">Phone</label>
            <input type="tel" name="phone" class="form-control" id="inputPhone" {if isset($member)}value="0{$member->getPhone()}"{/if} required>
          </div>
          <div class="col-md-6">
            <label for="inputPassword" class="form-label">Password</label>
            <input type="password" name="password" class="form-control" id="inputPassword" required>
          </div>
          <div class="col-md-6">
            <label for="inputPasswordRepeat" class="form-label">Repeat Password</label>
            <input type="password" name="password_repeat" class="form-control" id="inputPasswordRepeat" required>
          </div>
          <div class="col-12">
            <label for="inputAddress" class="form-label">Address</label>
            <input type="text" class="form-control" name="address" id="inputAddress" {if isset($member)}value="{$member->getAddress()}"{/if} placeholder="1234 Main St">
          </div>
          <div class="col-md-6">
            <label for="inputCity" class="form-label">City</label>
            <input type="text" class="form-control" name="city" id="inputCity" {if isset($member)}value="{$member->getCity()}"{/if} required>
          </div>
          <div class="col-md-4">
            <label for="inputCountry" class="form-label">Country</label>
            <select id="inputCountry" name="country" class="form-select" required>
          
              {foreach from=$countries item=country key=key name=name}
                <option value="{$country}" {if isset($member) and $member->getCountry() eq $country}selected{/if}>{$country}</option>
              {/foreach}
              
            </select>
          </div>
          <div class="col-md-2">
            <label for="inputZip" class="form-label">Zip</label>
            <input type="text" class="form-control" name="zip" id="inputZip" {if isset($member)}value="{$member->getZip()}"{/if} required>
          </div>
          <div class="col-12">
            <div class="form-check">
              <input class="form-check-input" name="check" type="checkbox" id="gridCheck" required>
              <label class="form-check-label" for="gridCheck">
                Check me out
              </label>
            </div>
          </div>
          <div class="col-12 text-center border-top p-4">
          
            <button type="submit" name="save" class="btn btn-primary">Save</button>
        
          </div>
        </form>
      </div>
    </div>
{/block}