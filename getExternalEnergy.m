function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)

% Eline
size(I)
Eline = I;


% Eedge
[Gmag,~] = imgradient(I);
Eedge = -1 * (Gmag);


% Eterm
filter_x = [0 0 0;0 -1 1;0 0 0];
filter_y = [0,0,0 ;0 -1 0;0 1 0];

filter_xx = [0 0 0;1 -2 1;0 0 0];
filter_yy = [0 1 0;0 -2 0;0 1 0];

Cx = conv2(I, filter_x, 'same');
Cy = conv2(I, filter_y, 'same');

Cxx = conv2(I, filter_xx, 'same');
Cyy = conv2(I, filter_yy, 'same');

Cxy = conv2(Cx, filter_y, 'same');

Eterm = (Cyy.*Cx.^2+2.*Cxy.*Cx.*Cy+Cxx.*Cy.^2)./(1+Cx.^2+Cy.^2).^(3/2);

% Eext

Eext = Wline*Eline + Wedge*Eedge + Wterm*Eterm;

end

